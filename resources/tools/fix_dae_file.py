from PIL import Image
import xml.etree.ElementTree as ET
import os
import copy

DAE_DIRS_PATH = "D:\\SteamLibrary\\steamapps\\common\\Homeworld\\GBXTools\\WorkshopTool\\current_project_processing\\ship_working_on"

SHIP_NAME = "vas_seth"

def fix_image_sizes():
    max_size = {}

    for f in os.listdir(os.path.join(DAE_DIRS_PATH, SHIP_NAME)):
        if f[-3:] == "TGA":

            if f.split("_")[0] not in max_size:
                max_size[f.split("_")[0]] = 0

            filename = os.path.join(DAE_DIRS_PATH, SHIP_NAME, f)
            with Image.open(filename) as im:
                print(f"{f} Image Size: {im.size}")
                max_size[f.split("_")[0]] = im.size[0] if im.size[0] > max_size[f.split("_")[0]] else max_size[f.split("_")[0]]

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

def fix_dae_engine_burns():
    # library_visual_scenes
    #   visual_scene
    #       node : ROOT_LOD[0]
    #           node : JNT[EngineNozzle#]
    #               node : NAVL[EngineNozzle#]
    #               node : BURN[EngineNozzle#]

    # Create JNT from NAVL coords -> rorate Y 180 -> Move BURN to JNT created

    engine_lights_name = 'NAVL[EngineNozzle'
    engine_burns_name = 'BURN[EngineBurn'

    dae_file = os.path.join(DAE_DIRS_PATH, SHIP_NAME, SHIP_NAME+".DAE")

    ns = {'collada':'http://www.collada.org/2005/11/COLLADASchema'}

    tree = ET.parse(dae_file)
    root = tree.getroot()

    root_nodes = root.find("collada:library_visual_scenes/collada:visual_scene/collada:node[@name='ROOT_LOD[0]']", ns)

    nodes = root_nodes.findall("collada:node", ns)
    n = 1
    for element in nodes:
        if engine_lights_name in element.attrib['name']:
            # copy then create JNT with new name, id and sid in root_nodes
            # change rotateY node to have 180
            # move BURN inside this node
            new_element = copy.deepcopy(element)
            new_element.set('name', f'JNT[EngineNozzle{n}]')
            new_element.set('id', f'JNT[EngineNozzle{n}]')
            new_element.set('sid', f'JNT[EngineNozzle{n}]')
            new_element.find("collada:rotate[@sid='rotateY']", ns).text = "0 1 0 180"
            root_nodes.append(new_element)


            n += 1

    nodes = root_nodes.findall("collada:node", ns)
    n = 1
    for element in nodes:
        if engine_burns_name in element.attrib['name']:
            # copy then create JNT with new name, id and sid in root_nodes
            # change rotateY node to have 180
            # move BURN inside this node
            new_element = copy.deepcopy(element)
            element.clear()
            new_element.set('name', f'BURN[EngineBurn{n}]')
            new_element.set('id', f'BURN[EngineBurn{n}]')
            new_element.set('sid', f'BURN[EngineBurn{n}]')
            root_nodes.find(f"collada:node[@name='JNT[EngineNozzle{n}]']", ns).append(new_element)
            n += 1

    tree.write(dae_file, encoding='utf-8', xml_declaration=True)


fix_image_sizes()
fix_dae_engine_burns()

