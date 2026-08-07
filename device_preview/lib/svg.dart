/// The embedded SVG subset renderer `package:device_preview` uses to draw
/// device bodies, exposed for reuse — tooling that previews device specs, or
/// apps that draw a device frame themselves.
///
/// It has no dependencies beyond Flutter itself and covers only what device
/// artwork needs: filled paths (plus `rect`, `circle`, `ellipse`, `polygon`),
/// groups, transforms, and clip paths. See [SvgDrawing] for the exact subset.
///
/// A separate library so that apps which never touch it pay nothing for it.
library;

export 'src/svg/svg_drawing.dart' show SvgDrawing, SvgShape;
export 'src/svg/svg_path_data.dart' show parseSvgPathData;
export 'src/svg/svg_xml.dart' show XmlElement, parseXmlDocument;
