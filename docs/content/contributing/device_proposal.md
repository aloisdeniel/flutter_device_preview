# New device proposal

## Create a SVG

All included device SVGs are exported from a single [Figma file](https://www.figma.com/file/WIamxcVDlHvxcCjLvJnwmR/DevicePreview-Frames?node-id=0%3A1).

If you want to propose a new device, or fix an existing one, you must provide a SVG that respect those rules :

* Having a unique `rect` or `path` filled with `#FF000000` for the screen shape.
* Having a unique `text` with all device properties.

```xml
<svg width="354" height="662" viewBox="0 0 354 662" fill="none" xmlns="http://www.w3.org/2000/svg">
    <!-- ALL YOUR FRAME DRAWING -->
    <!-- ... -->

    <!-- SCREEN SHAPE -->
    <rect x="15.6769" y="52.4312" width="320" height="569" rx="8" fill="#FF0000"/> 

    <!-- DEVICE PROPERTIES -->
    <text fill="black" xml:space="preserve" style="white-space: pre" font-family="Roboto" font-size="10.9388" letter-spacing="0em"><tspan x="36.1146" y="82.6886">name: Small Phone&#10;</tspan><tspan x="36.1146" y="95.6886">density: 2&#10;</tspan><tspan x="36.1146" y="108.689">screen_size: 320x569&#10;</tspan><tspan x="36.1146" y="121.689">safe_areas: 0,24,0,0|0,24,0,0</tspan></text> 
</svg>
```

You can see one of the included `devices_frame/assets` SVG files as a reference.

# Create an PR

Once your SVG file is ready, create [a new pull request](https://github.com/aloisdeniel/flutter_device_preview/pulls) with your SVG file added to the `device_frame/assets` directory and make sure to run the `dart device_frame/scripts/frame_generator.dart` program to generate the associated dart code.