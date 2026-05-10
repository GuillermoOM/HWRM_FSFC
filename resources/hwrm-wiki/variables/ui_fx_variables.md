# UI, FX, & Background Variables

> Reference for customizing the visual aspects of the game, including user interface layout, visual effect configurations, and background map properties.

---

## FX Configurations (`.fx`)

Effects are defined as `.fx` scripts in `Data/Art/FX/`. Each effect is based on a core `style` and configured via `properties`.

### FX Styles
- `STYLE_RING`: 2D/3D rings (explosions, shockwaves, hyperspace windows).
- `STYLE_BEAM`: Stretchy laser beams or engine trails.
- `STYLE_SPRAY`: Particle emitters (sparks, smoke, debris, fire).
- `STYLE_LIGHT`: Dynamic light sources.
- `STYLE_HYPERSPACE`: The complex 3D hyperspace tunnel effect.
- `STYLE_TRAIL`: Missile and engine trails.
- `STYLE_COMBO`: A container that triggers multiple other FX simultaneously.
- `STYLE_LENSFLARE`: Camera lens flares.

### Common Properties
Properties are defined using time-based arrays to animate values over the lifespan of the effect.
- **Duration**: Lifespan of the effect in seconds.
- **Loop**: `1` = repeat indefinitely until stopped.
- **Blending**: `0` = None, `1` = Alpha, `2` = Additive, `3` = Multiply, `4` = AdditiveAlpha.
- **Texture**: Path to the `.tga` or `.dds` texture file.
- **Colour**: An array of `[time, R, G, B, Alpha]` entries.

### Spray/Particle Properties
- **Emitter_Rate**: Particles spawned per second.
- **Emitter_Deviation**: Spread cone angle.
- **Emitter_InheritVelocity**: Percentage of parent object's velocity given to particles.
- **Particle_Dynamics**: Physics logic (`0`: Forward, `1`: Gravity Die, `2`: Gravity Bounce, `4`: Wind).
- **Gravwell_Strength**: Strength of gravity pull if dynamic is set to Gravwell.

---

## Background Configurations (`.lua`)

Background scripts located in `Data/Background/` control the environmental rendering for a specific map background, including sun rays, bloom, and ambient lighting.

### Core Variables
- **draw_stars**: `1.0` = enable the starfield.
- **draw_sphere**: `1.0` = enable the background sphere mesh.

### Sun & God Rays (`sun = {}`)
- **position**: `{ x, y, z }` location of the primary light source.
- **rayDensity**: Maximum length/spread of the god rays.
- **rayExposure**: Brightness multiplier for the rays.
- **rayArcRange / rayArcMotion**: Animate the cone of the rays over time.

### Post-Processing
- **bloom**: Configures the luminance thresholds, boost curves, and directional bloom for the map.
- **ship_gamma**: `gammaCurves` array allows map-specific color correction on ship models.
- **env.refl_scale**: Scales the intensity of environment map reflections on ship hulls.

---

## User Interface (UI)

The UI system is primarily constructed of XML-like Lua tables defining screen hierarchies, but relies on several core variable files in `Data/UI/` to define global visual rules.

### UIGlobalVariables
Defines the core colors, fonts, and interaction timings for the main UI.

### UIBlobs / UIPings
Defines the visual characteristics of the Tactical Overlay icons and sensor pings, including:
- Colors for different stances/relations (Friendly, Enemy, Allied).
- Fade distances for when icons disappear from the screen.
- Animation rates for ping circles.

### UIOrderFeedback
Controls the visual lines drawn between ships when issuing commands (Move, Attack, Guard).
- **Line Colors / Thickness**: Differentiated by command type.
- **Anim Rates**: Speed of the dashed lines moving along the path.
