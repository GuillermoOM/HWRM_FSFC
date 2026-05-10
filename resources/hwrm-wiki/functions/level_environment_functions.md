# Level & Environment Functions

> Functions used in map scripts (`.level`) to define asteroids, dust clouds, nebulas, salvage, and configure the Sensors Manager. Available in the **Level** scope.

---

## Environment Configuration

These functions are used in `Data/LevelData/` config files (like `asteroids.lua` or `dustclouds.lua`) to define the visual and gameplay properties of space objects.

### StartAsteroidConfig / StartDustCloudConfig / StartNebulaConfig / StartSalvageConfig
```lua
NewAsteroidType = StartAsteroidConfig()
NewDustCloudType = StartDustCloudConfig()
NewNebulaType = StartNebulaConfig()
NewSalvageType = StartSalvageConfig()
```
Instantiates a new configuration table for the respective environmental object.

### setDustCloudAmbient / setNebulaAmbient
```lua
setDustCloudAmbient(colorTable)
setNebulaAmbient(colorTable)
```
Sets the ambient lighting applied to ships inside the cloud. `colorTable` is `{r, g, b, a}` (0-255).

---

## Level Population

These functions are used in map generator scripts (like `multiplayer/dm_example.level`) to place objects in the map.

### addAsteroid
```lua
addAsteroid(asteroidType, position, resourceValue, rotX, rotY, rotZ, scale)
```
Places an asteroid. `position` is `{x, y, z}`.

### addDustCloud
```lua
addDustCloud(cloudName, cloudType, position, color, rot, size)
```
Places a dust cloud. `color` tints the cloud texture.

### addNebula
```lua
addNebula(nebulaName, nebulaType, position, color, rot, size)
```
Places a nebula.

### addSalvage
```lua
addSalvage(chunkType, position, resourceValue, rotX, rotY, rotZ, scale)
```
Places a piece of salvage (like debris) containing RUs.

### Universe_NebulaDelete
```lua
Universe_NebulaDelete(nebulaName, fadeTime)
```
Removes a named nebula from the map over `fadeTime` seconds.

### addReactiveFleetResourceSlot
```lua
addReactiveFleetResourceSlot(resourceType, position, rotX, rotY, rotZ)
```
Defines a spawn point for resources that scales based on the fleet size.

---

## Sensors Manager

### Sensors_Switch / Sensors_Toggle
```lua
Sensors_Switch(turnOn)
Sensors_Toggle(turnOn)
```
Forces the Sensors Manager open (`1`) or closed (`0`).

### Sensors_ManagerIsUp
```lua
result = Sensors_ManagerIsUp()
```
Returns `1` if the player currently has the Sensors Manager open.

### Sensors_EnableCameraZoom
```lua
Sensors_EnableCameraZoom(enable)
```

### Sensors_EnableToggle
```lua
Sensors_EnableToggle(enable)
```
Prevents or allows the player from opening/closing the Sensors Manager (used in tutorials).

### Sensors_SetCameraMinMax
```lua
Sensors_SetCameraMinMax(minZoom, maxZoom)
```

### Sensors_SetZoomOutDistance
```lua
Sensors_SetZoomOutDistance(distance)
```
Sets how far the camera zooms out when entering the Sensors Manager.

### Sensors_FlashWorldPlane
```lua
Sensors_FlashWorldPlane(flash)
```
Flashes the grid plane in the Sensors Manager to draw attention.

### addSensorsPlane
```lua
addSensorsPlane(distance, factor, colorTable)
```
Adds a visual plane to the Sensors Manager.
