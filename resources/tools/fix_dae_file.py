from typing import override
from PIL import Image
import xml.etree.ElementTree as ET
import os
from copy import deepcopy

DAE_DIRS_PATH = "D:\\SteamLibrary\\steamapps\\common\\Homeworld\\GBXTools\\WorkshopTool\\current_project_processing\\ship_working_on"
SHIP_NAME = "shi_trident"
LIGHT_NAME = "e"
BURN_NAME = "EngineBurn"


class NodeElement:
    translate: ET.Element = ET.Element("translate")
    matrix: list[ET.Element] = []
    ns: dict[str, str] = {"collada": "http://www.collada.org/2005/11/COLLADASchema"}

    def __init__(
        self,
        name: str,
        translate: ET.Element | None = None,
        matrix: list[ET.Element] | None = None,
    ):
        ET.register_namespace("", self.ns["collada"])

        if translate != None:
            self.translate = translate
        else:
            self.translate.text = "0.000000 0.000000 0.000000"
        if matrix != None:
            self.matrix = matrix
        else:
            self.matrix = [
                ET.Element("rotateX"),
                ET.Element("rotateY"),
                ET.Element("rotateZ"),
            ]
            self.matrix[0].text = "1 0 0 0.000000"
            self.matrix[1].text = "0 1 0 0.000000"
            self.matrix[2].text = "0 0 1 0.000000"

        self.name: str = name
        self.xmlnode: ET.Element = ET.Element(
            "node", {"id": name, "name": name, "sid": name}
        )
        self.xmlnode.append(self.translate)
        self.xmlnode.extend(self.matrix)
        extra = ET.Element("extra")
        technique = ET.Element("technique", attrib={"profile": "FCOLLADA"})
        visibility = ET.Element("visibility")
        visibility.text = "1.000000"
        technique.append(visibility)
        extra.append(technique)
        self.xmlnode.append(extra)

    @override
    def __str__(self) -> str:
        return ET.tostring(self.xmlnode, encoding="unicode")


def fix_image_sizes():
    max_size = {}

    for f in os.listdir(os.path.join(DAE_DIRS_PATH, SHIP_NAME)):
        if f[-3:] == "TGA":

            if f.split("_")[0] not in max_size:
                max_size[f.split("_")[0]] = 0

            filename = os.path.join(DAE_DIRS_PATH, SHIP_NAME, f)
            with Image.open(filename) as im:
                print(f"{f} Image Size: {im.size}")
                max_size[f.split("_")[0]] = (
                    im.size[0]
                    if im.size[0] > max_size[f.split("_")[0]]
                    else max_size[f.split("_")[0]]
                )

    print(f"Max sizes found: \n{max_size}")

    for f in os.listdir(os.path.join(DAE_DIRS_PATH, SHIP_NAME)):
        if f[-3:] == "TGA":
            print(f"Opening {f}")
            filename = os.path.join(DAE_DIRS_PATH, SHIP_NAME, f)
            try:
                with Image.open(filename) as im:
                    newsize = (max_size[f.split("_")[0]], max_size[f.split("_")[0]])
                    im1 = im.resize(newsize)
                    im1.save(os.path.join(DAE_DIRS_PATH, SHIP_NAME, f))
                    print(f"File {f} Converted!")
            except OSError:
                print("cannot convert", f)


def fix_dae():
    # library_visual_scenes
    #   visual_scene
    #       node : ROOT_LOD[0]
    #           node : JNT[EngineNozzle#]
    #               node : NAVL[EngineNozzle#]
    #               node : BURN[EngineNozzle#]

    # Create JNT from NAVL coords -> rorate Y 180 -> Move BURN to JNT created

    engine_lights_name = f"NAVL[{LIGHT_NAME}"
    engine_burns_name = f"BURN[{BURN_NAME}"

    dae_file = os.path.join(DAE_DIRS_PATH, SHIP_NAME, SHIP_NAME + ".DAE")

    ns = {"collada": "http://www.collada.org/2005/11/COLLADASchema"}

    ET.register_namespace("", ns["collada"])
    tree: ET.ElementTree[ET.Element[str]] | None = ET.parse(dae_file)
    root: ET.Element = tree.getroot()

    lod_node: ET.Element | None = root.find(
        "collada:library_visual_scenes/collada:visual_scene/collada:node[@name='ROOT_LOD[0]']",
        ns,
    )

    # Let's find all BURN nodes inside NAVL nodes and put them in their own EngineNozzle JNT nodes

    if lod_node is not None:
        engine_light_nodes: list[ET.Element] = []
        engine_burn_nodes: list[ET.Element] = []
        i = 1
        while True:
            light_node: ET.Element | None = lod_node.find(
                f"collada:node[@name='{engine_lights_name}{i}]']", ns
            )
            if light_node is not None:
                print(f"Found light {engine_lights_name}{i}]")
                engine_light_nodes.append(light_node)

                burn_node: ET.Element | None = light_node.find(
                    f"collada:node[@name='{engine_burns_name}{i}]']", ns
                )
                if burn_node is not None:
                    print(f"Found burn {engine_burns_name}{i}]")
                    engine_burn_nodes.append(deepcopy(burn_node))
                    light_node.remove(burn_node)
                else:
                    print(f"Couldn't find burn {engine_burns_name}{i}]")
            else:
                print(f"Couldn't find light {engine_lights_name}{i}]")
                break
            i += 1
        for n, light_node in enumerate(engine_light_nodes):
            # copy then create JNT with new name, id and sid in lod_nodes
            # change rotateY node to have 180
            # move BURN inside this node
            nozzle_node: NodeElement = NodeElement(
                name=f"JNT[EngineNozzle{n+1}]",
                translate=light_node.find("collada:translate", ns),
                matrix=light_node.findall("collada:rotate", ns),
            )
            nozzle_node.matrix[1].text = "0 1 0 180.000000"
            nozzle_node.xmlnode.append(engine_burn_nodes[n])
            # print(f"Created Nozzle {nozzle_node}")
            lod_node.append(nozzle_node.xmlnode)

    # Now let's Fix all Goblins by renaming every GOBG instance in node attributes with MULT

    for element in root.iter():
        # Check each attribute of the element
        for attr, value in element.items():
            if "GOBG" in value:
                print(f"found element: {element}, with attribute: '{attr}' as {value}")
                new_value = value.replace("GOBG", "MULT")
                print(f"replaced {value} with {new_value}")
                element.set(attr, new_value)
                # print(f"{element.attrib}\n")

    tree.write(dae_file, encoding="utf-8", xml_declaration=True)


if __name__ == "__main__":
    fix_image_sizes()
    fix_dae()
