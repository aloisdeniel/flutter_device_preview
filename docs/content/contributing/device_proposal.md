# New device proposal

## Design files

All devices must be added as dedicated frames in the [offical Figma file](https://www.figma.com/file/WIamxcVDlHvxcCjLvJnwmR/DevicePreview---Frames?node-id=0%3A1).

Each device frame mush have a `Screen` node which must contains a flatten shape, and a `Body` group which contains the device body elements.

## Generate painter code

All the custom painter code is generated with [fluttershapemaker](https://fluttershapemaker.com/) and is then manually improved. 

# Send a pull request

Once your design is ready, create [a new pull request](https://github.com/aloisdeniel/flutter_device_preview/pulls) with your files added to the `device_frame/lib/src/devices/` directory.