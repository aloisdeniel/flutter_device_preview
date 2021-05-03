part of 'devices.dart';

final _allDevices = [
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.windows,
      DeviceType.tablet,
      'surface3',
    ),
    name: 'Microsoft Surface 3',
    pixelRatio: 1.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 20.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 20.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: parseSvgPathData(
        'M1851.85 182.932L1851.85 2728.07H155.094L155.094 182.932L1851.85 182.932Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="2007" height="2911" viewBox="0 0 2007 2911" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_ii" x="-0.000488281" y="0" width="2006.95" height="2912.33" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="3.97678"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.32559"/>
<feGaussianBlur stdDeviation="1.32559"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter1_ii" x="1992.36" y="182.932" width="15.9072" height="2545.14" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="1.32559"/>
<feGaussianBlur stdDeviation="1.32559"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.32559"/>
<feGaussianBlur stdDeviation="1.32559"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter2_d" x="5.30179" y="5.30252" width="1996.34" height="2900.4" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.98839"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter3_dii" x="9.27853" y="10.6045" width="1988.39" height="2892.44" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.32559"/>
<feGaussianBlur stdDeviation="0.662796"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="2.65118"/>
<feGaussianBlur stdDeviation="0.662796"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-2.65118"/>
<feGaussianBlur stdDeviation="0.662796"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter4_d" x="1907.53" y="1439.59" width="31.8142" height="31.8142" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="2.65118" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.32559"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter5_f" x="1913.2" y="1443.94" width="12.509" height="12.509" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.80167" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter6_f" x="1914.53" y="1450.57" width="15.1602" height="15.1602" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.80167" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter7_f" x="1922.48" y="1457.2" width="12.509" height="12.509" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.80167" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter8_f" x="1921.79" y="1445.19" width="11.7994" height="14.2223" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.80167" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter9_ii" x="1912.83" y="1515.15" width="19.8839" height="21.2095" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.32559"/>
<feGaussianBlur stdDeviation="0.662796"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.32559"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.05 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<linearGradient id="paint0_linear" x1="2006.95" y1="0" x2="-0.000366211" y2="-8.77264e-05" gradientUnits="userSpaceOnUse">
<stop stop-color="#C1C1C1"/>
<stop offset="1" stop-color="#909090"/>
</linearGradient>
<radialGradient id="paint1_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(2006.95) rotate(-180) scale(194.852 282.625)">
<stop stop-color="white"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint2_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(2006.95 2911) rotate(-180) scale(194.852 282.625)">
<stop stop-color="white"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint3_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1003.47 1455.5) rotate(-180) scale(619.552 2826.61)">
<stop stop-color="white" stop-opacity="0.01"/>
<stop offset="1" stop-color="white" stop-opacity="0.5"/>
</radialGradient>
<radialGradient id="paint4_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(-0.000428513 1425.3) rotate(-180) scale(661.139 2517.05)">
<stop/>
<stop offset="1" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint5_linear" x1="64.6843" y1="1408.59" x2="-0.000427782" y2="1408.59" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.5"/>
<stop offset="1" stop-opacity="0.5"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="2006.95" y1="0" x2="-0.000366211" y2="-8.77264e-05" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.5"/>
<stop offset="0.0254035" stop-color="white" stop-opacity="0.5"/>
<stop offset="0.045714" stop-opacity="0.5"/>
<stop offset="0.0983374" stop-opacity="0.5"/>
<stop offset="0.16883" stop-color="#7A7777" stop-opacity="0.5"/>
<stop offset="0.191128" stop-opacity="0.5"/>
<stop offset="0.341913" stop-color="white" stop-opacity="0.5"/>
<stop offset="1" stop-color="white" stop-opacity="0.5"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="0" y1="0" x2="0" y2="145.815" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="0.401915" stop-color="white"/>
<stop offset="0.466575"/>
<stop offset="1" stop-color="white"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="2090.3" y1="-42.1113" x2="2090.3" y2="103.704" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="0.401915" stop-color="white"/>
<stop offset="0.466575"/>
<stop offset="1" stop-color="white"/>
</linearGradient>
<linearGradient id="paint9_linear" x1="-5.92432" y1="-140.647" x2="-5.92432" y2="5.16766" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="0.401915" stop-color="white"/>
<stop offset="0.466575"/>
<stop offset="1" stop-color="white"/>
</linearGradient>
<linearGradient id="paint10_linear" x1="0" y1="0" x2="0" y2="145.815" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="0.401915" stop-color="white"/>
<stop offset="0.466575"/>
<stop offset="1" stop-color="white"/>
</linearGradient>
<radialGradient id="paint11_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(2008.62 198.799) rotate(90) scale(12.4015 2381.09)">
<stop/>
<stop offset="1" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint12_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(4552.08 198.28) rotate(90) scale(12.4015 2381.09)">
<stop/>
<stop offset="1" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint13_linear" x1="1996.34" y1="10.6045" x2="10.6042" y2="10.6044" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.3"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint14_linear" x1="1996.34" y1="10.6045" x2="10.6042" y2="10.6044" gradientUnits="userSpaceOnUse">
<stop stop-color="#212121"/>
<stop offset="0.218653" stop-color="#0C0C0C"/>
<stop offset="1" stop-color="#151514"/>
</linearGradient>
<radialGradient id="paint15_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1944.19 1493.66) rotate(49.5605) scale(37.5684)">
<stop stop-color="#E3E0E0"/>
<stop offset="1" stop-color="#252728"/>
</radialGradient>
<linearGradient id="paint16_linear" x1="1912.83" y1="1444.9" x2="1912.83" y2="1466.1" gradientUnits="userSpaceOnUse">
<stop stop-color="#3343AC"/>
<stop offset="1" stop-color="#1E2462"/>
</linearGradient>
<linearGradient id="paint17_linear" x1="1910.18" y1="1518.8" x2="1917.47" y2="1538.68" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.5"/>
<stop offset="1" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint18_linear" x1="1911.83" y1="1576.29" x2="1920.12" y2="1592.2" gradientUnits="userSpaceOnUse">
<stop/>
<stop offset="1" stop-color="#111111"/>
</linearGradient>
<linearGradient id="paint19_linear" x1="1035.25" y1="2778.44" x2="969.008" y2="2778.44" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.5"/>
<stop offset="1" stop-opacity="0.5"/>
</linearGradient>
<clipPath id="clip0">
<rect width="2911" height="2006.95" fill="white" transform="translate(2006.95) rotate(90)"/>
</clipPath>
<clipPath id="clip1">
<rect width="2911" height="2006.95" fill="white" transform="translate(2006.95) rotate(90)"/>
</clipPath>
<clipPath id="clip2">
<rect width="155.094" height="45.0701" fill="white" transform="translate(1945.97 1432.96) rotate(90)"/>
</clipPath>
<clipPath id="clip3">
<rect width="45.0701" height="45.0701" fill="white" transform="translate(1945.97 1432.96) rotate(90)"/>
</clipPath>
<clipPath id="clip4">
<rect width="21.2095" height="21.2095" fill="white" transform="translate(1934.04 1444.9) rotate(90)"/>
</clipPath>
<clipPath id="clip5">
<rect width="15.9071" height="15.9071" fill="white" transform="translate(1931.39 1572.15) rotate(90)"/>
</clipPath>
</defs>
<g clip-path="url(#clip0)">
<g clip-path="url(#clip1)">
<g filter="url(#filter0_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M2006.95 2850.6L2006.95 2729.39C2006.95 2728.66 2006.35 2728.07 2005.62 2728.07L2005.62 182.932C2006.35 182.932 2006.95 182.338 2006.95 181.606L2006.95 60.7347C2006.95 27.1919 1979.75 -1.18859e-06 1946.21 -2.65485e-06L60.7356 -8.50715e-05C27.1915 -8.65378e-05 -0.0003674 27.1918 -0.000368866 60.7346L-0.000490779 2849.78C-0.000492251 2883.45 27.548 2911 61.218 2911L1946.55 2911C1979.91 2911 2006.95 2883.96 2006.95 2850.6Z" fill="url(#paint0_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M2006.95 2850.6L2006.95 2729.39C2006.95 2728.66 2006.35 2728.07 2005.62 2728.07L2005.62 182.932C2006.35 182.932 2006.95 182.338 2006.95 181.606L2006.95 60.7347C2006.95 27.1919 1979.75 -1.18859e-06 1946.21 -2.65485e-06L60.7356 -8.50715e-05C27.1915 -8.65378e-05 -0.0003674 27.1918 -0.000368866 60.7346L-0.000490779 2849.78C-0.000492251 2883.45 27.548 2911 61.218 2911L1946.55 2911C1979.91 2911 2006.95 2883.96 2006.95 2850.6Z" fill="url(#paint1_radial)" fill-opacity="0.9"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M2006.95 2850.6L2006.95 2729.39C2006.95 2728.66 2006.35 2728.07 2005.62 2728.07L2005.62 182.932C2006.35 182.932 2006.95 182.338 2006.95 181.606L2006.95 60.7347C2006.95 27.1919 1979.75 -1.18859e-06 1946.21 -2.65485e-06L60.7356 -8.50715e-05C27.1915 -8.65378e-05 -0.0003674 27.1918 -0.000368866 60.7346L-0.000490779 2849.78C-0.000492251 2883.45 27.548 2911 61.218 2911L1946.55 2911C1979.91 2911 2006.95 2883.96 2006.95 2850.6Z" fill="url(#paint2_radial)" fill-opacity="0.9"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M2006.95 2850.6L2006.95 2729.39C2006.95 2728.66 2006.35 2728.07 2005.62 2728.07L2005.62 182.932C2006.35 182.932 2006.95 182.338 2006.95 181.606L2006.95 60.7347C2006.95 27.1919 1979.75 -1.18859e-06 1946.21 -2.65485e-06L60.7356 -8.50715e-05C27.1915 -8.65378e-05 -0.0003674 27.1918 -0.000368866 60.7346L-0.000490779 2849.78C-0.000492251 2883.45 27.548 2911 61.218 2911L1946.55 2911C1979.91 2911 2006.95 2883.96 2006.95 2850.6Z" fill="url(#paint3_radial)" fill-opacity="0.7"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M2006.95 2850.6L2006.95 2729.39C2006.95 2728.66 2006.35 2728.07 2005.62 2728.07L2005.62 182.932C2006.35 182.932 2006.95 182.338 2006.95 181.606L2006.95 60.7347C2006.95 27.1919 1979.75 -1.18859e-06 1946.21 -2.65485e-06L60.7356 -8.50715e-05C27.1915 -8.65378e-05 -0.0003674 27.1918 -0.000368866 60.7346L-0.000490779 2849.78C-0.000492251 2883.45 27.548 2911 61.218 2911L1946.55 2911C1979.91 2911 2006.95 2883.96 2006.95 2850.6Z" fill="url(#paint4_radial)" fill-opacity="0.3"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M2006.95 2850.6L2006.95 2729.39C2006.95 2728.66 2006.35 2728.07 2005.62 2728.07L2005.62 182.932C2006.35 182.932 2006.95 182.338 2006.95 181.606L2006.95 60.7347C2006.95 27.1919 1979.75 -1.18859e-06 1946.21 -2.65485e-06L60.7356 -8.50715e-05C27.1915 -8.65378e-05 -0.0003674 27.1918 -0.000368866 60.7346L-0.000490779 2849.78C-0.000492251 2883.45 27.548 2911 61.218 2911L1946.55 2911C1979.91 2911 2006.95 2883.96 2006.95 2850.6Z" fill="url(#paint5_linear)" fill-opacity="0.4"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M2006.95 2850.6L2006.95 2729.39C2006.95 2728.66 2006.35 2728.07 2005.62 2728.07L2005.62 182.932C2006.35 182.932 2006.95 182.338 2006.95 181.606L2006.95 60.7347C2006.95 27.1919 1979.75 -1.18859e-06 1946.21 -2.65485e-06L60.7356 -8.50715e-05C27.1915 -8.65378e-05 -0.0003674 27.1918 -0.000368866 60.7346L-0.000490779 2849.78C-0.000492251 2883.45 27.548 2911 61.218 2911L1946.55 2911C1979.91 2911 2006.95 2883.96 2006.95 2850.6Z" fill="url(#paint6_linear)" fill-opacity="0.5" style="mix-blend-mode:multiply"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="-1" y="0" width="2008" height="2911">
<path fill-rule="evenodd" clip-rule="evenodd" d="M2006.95 2850.6L2006.95 2729.39C2006.95 2728.66 2006.35 2728.07 2005.62 2728.07L2005.62 182.932C2006.35 182.932 2006.95 182.338 2006.95 181.606L2006.95 60.7347C2006.95 27.1919 1979.75 -1.18859e-06 1946.21 -2.65485e-06L60.7356 -8.50715e-05C27.1915 -8.65378e-05 -0.0003674 27.1918 -0.000368866 60.7346L-0.000490779 2849.78C-0.000492251 2883.45 27.548 2911 61.218 2911L1946.55 2911C1979.91 2911 2006.95 2883.96 2006.95 2850.6Z" fill="white"/>
</mask>
<g mask="url(#mask0)">
<rect width="271.746" height="145.815" transform="matrix(-0.5 -0.866025 -0.866025 0.5 2090.3 2950.46)" fill="url(#paint7_linear)" fill-opacity="0.4" style="mix-blend-mode:multiply"/>
<rect x="2090.3" y="-42.1113" width="271.746" height="145.815" transform="rotate(120 2090.3 -42.1113)" fill="url(#paint8_linear)" fill-opacity="0.4" style="mix-blend-mode:multiply"/>
<rect x="-5.92432" y="-140.647" width="271.746" height="145.815" transform="rotate(45 -5.92432 -140.647)" fill="url(#paint9_linear)" fill-opacity="0.4" style="mix-blend-mode:multiply"/>
<rect width="271.746" height="145.815" transform="matrix(0.707107 -0.707107 -0.707107 -0.707107 -5.92432 3049.71)" fill="url(#paint10_linear)" fill-opacity="0.4" style="mix-blend-mode:multiply"/>
<g opacity="0.4" filter="url(#filter1_ii)">
<rect x="2006.95" y="182.932" width="2545.14" height="13.2559" transform="rotate(90 2006.95 182.932)" fill="url(#paint11_radial)"/>
<rect x="2006.95" y="182.932" width="2545.14" height="13.2559" transform="rotate(90 2006.95 182.932)" fill="url(#paint12_radial)"/>
</g>
</g>
</g>
<g filter="url(#filter2_d)">
<mask id="path-8-outside-1" maskUnits="userSpaceOnUse" x="8.34094" y="8.60441" width="1990" height="2894" fill="black">
<rect fill="white" x="8.34094" y="8.60441" width="1990" height="2894"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1849.65 2897.74L1602.19 2897.74C1599.61 2899.46 1596.55 2900.39 1593.4 2900.39L60.9766 2900.39C33.1577 2900.39 10.6041 2877.84 10.6041 2850.02L10.6042 60.9769C10.6042 33.158 33.1578 10.6044 60.9767 10.6044L1593.4 10.6045C1596.55 10.6045 1599.61 11.5396 1602.19 13.2553L1849.65 13.2553C1852.24 11.5396 1855.29 10.6045 1858.44 10.6045L1945.97 10.6045C1973.79 10.6045 1996.34 33.1581 1996.34 60.977L1996.34 2850.02C1996.34 2877.84 1973.79 2900.39 1945.97 2900.39L1858.44 2900.39C1855.29 2900.39 1852.23 2899.46 1849.65 2897.74Z"/>
</mask>
<path d="M1602.19 2897.74L1602.19 2896.42L1601.8 2896.42L1601.46 2896.64L1602.19 2897.74ZM1849.65 2897.74L1850.38 2896.64L1850.05 2896.42L1849.65 2896.42L1849.65 2897.74ZM1593.4 2900.39L1593.4 2901.72L1593.4 2900.39ZM60.9766 2900.39L60.9766 2899.07L60.9766 2900.39ZM60.9767 10.6044L60.9767 9.27882L60.9767 10.6044ZM1593.4 10.6045L1593.4 11.9301L1593.4 10.6045ZM1602.19 13.2553L1601.46 14.36L1601.79 14.5808L1602.19 14.5808L1602.19 13.2553ZM1849.65 13.2553L1849.65 14.5809L1850.05 14.5809L1850.38 14.36L1849.65 13.2553ZM1945.97 2900.39L1945.97 2899.07L1945.97 2900.39ZM1858.44 2900.39L1858.44 2901.72L1858.44 2900.39ZM1602.19 2899.07L1849.65 2899.07L1849.65 2896.42L1602.19 2896.42L1602.19 2899.07ZM1593.4 2901.72C1596.81 2901.72 1600.12 2900.71 1602.93 2898.85L1601.46 2896.64C1599.09 2898.21 1596.29 2899.07 1593.4 2899.07L1593.4 2901.72ZM60.9766 2901.72L1593.4 2901.72L1593.4 2899.07L60.9766 2899.07L60.9766 2901.72ZM9.27856 2850.02C9.27856 2878.57 32.4257 2901.72 60.9766 2901.72L60.9766 2899.07C33.8898 2899.07 11.9297 2877.11 11.9297 2850.02L9.27856 2850.02ZM9.27868 60.9769L9.27856 2850.02L11.9297 2850.02L11.9298 60.9769L9.27868 60.9769ZM60.9767 9.27882C32.4258 9.27881 9.27869 32.4259 9.27868 60.9769L11.9298 60.9769C11.9298 33.8901 33.8899 11.93 60.9767 11.93L60.9767 9.27882ZM1593.4 9.27888L60.9767 9.27882L60.9767 11.93L1593.4 11.9301L1593.4 9.27888ZM1602.92 12.1505C1600.12 10.292 1596.81 9.27888 1593.4 9.27888L1593.4 11.9301C1596.29 11.9301 1599.09 12.7872 1601.46 14.36L1602.92 12.1505ZM1849.65 11.9297L1602.19 11.9297L1602.19 14.5808L1849.65 14.5809L1849.65 11.9297ZM1858.44 9.27889C1855.03 9.27889 1851.72 10.292 1848.92 12.1506L1850.38 14.36C1852.75 12.7872 1855.55 11.9301 1858.44 11.9301L1858.44 9.27889ZM1945.97 9.2789L1858.44 9.27889L1858.44 11.9301L1945.97 11.9301L1945.97 9.2789ZM1997.67 60.977C1997.67 32.426 1974.52 9.2789 1945.97 9.2789L1945.97 11.9301C1973.06 11.9301 1995.02 33.8902 1995.02 60.977L1997.67 60.977ZM1997.67 2850.02L1997.67 60.977L1995.02 60.977L1995.02 2850.02L1997.67 2850.02ZM1945.97 2901.72C1974.52 2901.72 1997.67 2878.57 1997.67 2850.02L1995.02 2850.02C1995.02 2877.11 1973.06 2899.07 1945.97 2899.07L1945.97 2901.72ZM1858.44 2901.72L1945.97 2901.72L1945.97 2899.07L1858.44 2899.07L1858.44 2901.72ZM1848.91 2898.85C1851.72 2900.71 1855.03 2901.72 1858.44 2901.72L1858.44 2899.07C1855.55 2899.07 1852.75 2898.21 1850.38 2896.64L1848.91 2898.85Z" fill="url(#paint13_linear)" mask="url(#path-8-outside-1)"/>
</g>
<rect x="1862.46" y="13.2549" width="71.582" height="288.979" transform="rotate(90 1862.46 13.2549)" fill="#111111"/>
<rect x="1862.46" y="2826.16" width="71.582" height="288.979" transform="rotate(90 1862.46 2826.16)" fill="#111111"/>
<g filter="url(#filter3_dii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1847.19 2895.74C1850.18 2898.72 1854.22 2900.39 1858.44 2900.39L1945.97 2900.39C1973.79 2900.39 1996.34 2877.84 1996.34 2850.02L1996.34 60.977C1996.34 33.1581 1973.79 10.6045 1945.97 10.6045L1858.44 10.6045C1854.22 10.6045 1850.18 12.2814 1847.19 15.2639L1836.63 25.8302C1833.64 28.8128 1829.6 30.4884 1825.38 30.4884L1626.46 30.4884C1622.24 30.4884 1618.2 28.8128 1615.21 25.8302L1604.65 15.2639C1601.67 12.2813 1597.62 10.6045 1593.4 10.6045L60.9767 10.6044C33.1578 10.6044 10.6042 33.158 10.6042 60.9769L10.6041 2850.02C10.6041 2877.84 33.1577 2900.39 60.9766 2900.39L1593.4 2900.39C1597.62 2900.39 1601.67 2898.72 1604.65 2895.74L1615.21 2885.17C1618.2 2882.19 1622.24 2880.51 1626.46 2880.51L1825.38 2880.51C1829.6 2880.51 1833.64 2882.19 1836.63 2885.17L1847.19 2895.74Z" fill="url(#paint14_linear)"/>
</g>
<rect x="1859.8" y="174.978" width="2561.04" height="1715.32" transform="rotate(90 1859.8 174.978)" fill="#2A2929"/>
<g clip-path="url(#clip2)">
<g opacity="0.5" clip-path="url(#clip3)">
<circle cx="1923.43" cy="1455.5" r="22.5351" transform="rotate(90 1923.43 1455.5)" fill="url(#paint15_radial)"/>
<g clip-path="url(#clip4)">
<g filter="url(#filter4_d)">
<circle cx="1923.43" cy="1455.5" r="10.6047" transform="rotate(90 1923.43 1455.5)" fill="url(#paint16_linear)"/>
</g>
<mask id="mask1" mask-type="alpha" maskUnits="userSpaceOnUse" x="1912" y="1444" width="23" height="23">
<circle cx="1923.43" cy="1455.5" r="10.6047" transform="rotate(90 1923.43 1455.5)" fill="white"/>
</mask>
<g mask="url(#mask1)">
<g filter="url(#filter5_f)">
<circle cx="1919.46" cy="1450.2" r="2.65118" transform="rotate(90 1919.46 1450.2)" fill="#4297D8"/>
</g>
<g filter="url(#filter6_f)">
<circle cx="1922.11" cy="1458.15" r="3.97678" transform="rotate(90 1922.11 1458.15)" fill="#17154B"/>
</g>
<g filter="url(#filter7_f)">
<circle cx="1928.74" cy="1463.45" r="2.65118" transform="rotate(90 1928.74 1463.45)" fill="#A3D1FA"/>
</g>
<g filter="url(#filter8_f)">
<ellipse cx="1927.69" cy="1452.3" rx="3.97678" ry="1.32559" transform="rotate(60 1927.69 1452.3)" fill="#2934CD"/>
</g>
</g>
</g>
</g>
<g filter="url(#filter9_ii)">
<circle cx="1922.77" cy="1525.09" r="9.94194" transform="rotate(90 1922.77 1525.09)" fill="#212121"/>
<circle cx="1922.77" cy="1525.09" r="9.94194" transform="rotate(90 1922.77 1525.09)" fill="url(#paint17_linear)" fill-opacity="0.2"/>
</g>
<g clip-path="url(#clip5)">
<circle opacity="0.2" cx="1923.43" cy="1580.1" r="7.95355" transform="rotate(90 1923.43 1580.1)" fill="url(#paint18_linear)"/>
<circle opacity="0.6" cx="1923.43" cy="1580.11" r="5.30237" transform="rotate(90 1923.43 1580.11)" fill="#0A0A0A"/>
</g>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1029.93 2808.73C1031.87 2820.61 1033.56 2832.72 1035.25 2844.6L1034.77 2844.6L1003.82 2844.6C1003.82 2832.72 1003.58 2820.61 1003.58 2808.73L1029.93 2808.73ZM1025.82 2778.44C1027.27 2787.41 1028.48 2796.37 1029.45 2805.58L1003.58 2805.58C1003.58 2796.37 1003.34 2787.41 1003.34 2778.44L1025.82 2778.44ZM1000.68 2778.44C1000.68 2787.41 1000.44 2796.37 1000.68 2805.58L974.568 2805.58C975.777 2796.37 976.986 2787.41 978.195 2778.44L1000.68 2778.44ZM1000.44 2808.73L1000.44 2844.6L970.458 2844.6L969.008 2844.6C970.942 2832.72 972.392 2820.61 974.085 2808.73L1000.44 2808.73Z" fill="white"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1029.93 2808.73C1031.87 2820.61 1033.56 2832.72 1035.25 2844.6L1034.77 2844.6L1003.82 2844.6C1003.82 2832.72 1003.58 2820.61 1003.58 2808.73L1029.93 2808.73ZM1025.82 2778.44C1027.27 2787.41 1028.48 2796.37 1029.45 2805.58L1003.58 2805.58C1003.58 2796.37 1003.34 2787.41 1003.34 2778.44L1025.82 2778.44ZM1000.68 2778.44C1000.68 2787.41 1000.44 2796.37 1000.68 2805.58L974.568 2805.58C975.777 2796.37 976.986 2787.41 978.195 2778.44L1000.68 2778.44ZM1000.44 2808.73L1000.44 2844.6L970.458 2844.6L969.008 2844.6C970.942 2832.72 972.392 2820.61 974.085 2808.73L1000.44 2808.73Z" fill="url(#paint19_linear)" fill-opacity="0.15"/>
</g>



</svg>
''',
    frameSize: Size(2007.0, 2911.0),
    screenSize: Size(1280.0, 1920.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.iOS,
      DeviceType.phone,
      'iphone-11',
    ),
    name: 'iPhone 11',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 44.0,
      right: 0.0,
      bottom: 34.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 44.0,
      top: 0.0,
      right: 44.0,
      bottom: 21.0,
    ),
    screenPath: parseSvgPathData(
        'M234.646 67.7231C241.495 67.7231 247.046 73.2748 247.046 80.1231C247.687 91.7244 249.955 99.0797 253.544 105.791C257.783 113.718 264.005 119.94 271.933 124.18C279.86 128.419 288.764 130.677 304.207 130.677H628.655C644.098 130.677 653.002 128.419 660.929 124.18C668.857 119.94 675.078 113.718 679.318 105.791C682.906 99.081 685.094 91.6474 685.815 80.1231C685.815 73.2748 691.367 67.7231 698.216 67.7231L759.833 67.7231C795.123 67.7231 807.92 71.3976 820.822 78.2975C833.724 85.1974 843.849 95.3227 850.749 108.224C857.649 121.126 861.323 133.923 861.323 169.214V1675.53C861.323 1710.82 857.649 1723.61 850.749 1736.51C843.849 1749.42 833.724 1759.54 820.822 1766.44C807.92 1773.34 795.123 1777.02 759.833 1777.02H173.029C137.739 1777.02 124.941 1773.34 112.04 1766.44C99.1381 1759.54 89.0128 1749.42 82.1129 1736.51C75.213 1723.61 71.5386 1710.82 71.5386 1675.53V169.214C71.5386 133.923 75.213 121.126 82.1129 108.224C89.0128 95.3227 99.1381 85.1974 112.04 78.2975C124.941 71.3976 137.739 67.7231 173.029 67.7231H234.646Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="934" height="1860" viewBox="0 0 934 1860" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_ii" x="3.81543" y="0" width="925.231" height="1844.74" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="6.2"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.109804 0 0 0 0 0.105882 0 0 0 0 0.129412 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="3.81538"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.752349 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter1_d" x="22.8923" y="19.0769" width="887.077" height="1806.58" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.250849 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter2_i" x="425.947" y="1841.88" width="82.8763" height="3.81538" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.953846"/>
<feGaussianBlur stdDeviation="0.953846"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.248432 0 0 0 0 0.248432 0 0 0 0 0.248432 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter3_i" x="27.6614" y="54.4082" width="66.1063" height="1746.62" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-4.76923"/>
<feGaussianBlur stdDeviation="4.76923"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.7012 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter4_i" x="834.329" y="54.4082" width="66.1063" height="1746.62" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-4.76923"/>
<feGaussianBlur stdDeviation="4.76923"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.7012 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter5_ii" x="0" y="249.908" width="7.63077" height="73.4462" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4.76923"/>
<feGaussianBlur stdDeviation="0.953846"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.65257 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-4.76923"/>
<feGaussianBlur stdDeviation="0.953846"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.648749 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter6_ii" x="0" y="374.862" width="7.63077" height="133.538" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4.76923"/>
<feGaussianBlur stdDeviation="0.953846"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.65257 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-4.76923"/>
<feGaussianBlur stdDeviation="0.953846"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.648749 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter7_ii" x="0" y="535.108" width="7.63077" height="133.538" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4.76923"/>
<feGaussianBlur stdDeviation="0.953846"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.65257 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-4.76923"/>
<feGaussianBlur stdDeviation="0.953846"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.648749 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter8_ii" x="926.185" y="418.739" width="7.63077" height="207.938" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4.76923"/>
<feGaussianBlur stdDeviation="0.953846"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.498953 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-4.76923"/>
<feGaussianBlur stdDeviation="0.953846"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.497368 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter9_iii" x="413.015" y="73.4463" width="106.831" height="17.1692" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="2.86154" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.43077"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.795035 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-2.86154"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.80013 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.90769"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.197067 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter10_dd" x="543.692" y="66.7694" width="29.5692" height="29.5692" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="3.81538" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.90769"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="1.90769" operator="dilate" in="SourceAlpha" result="effect2_dropShadow"/>
<feOffset/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
</filter>
<filter id="filter11_f" x="546.482" y="70.9697" width="12.5704" height="19.2904" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.94462" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter12_f" x="555.065" y="70.5109" width="16.3631" height="18.2708" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.94462" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter13_f" x="550.409" y="79.5293" width="18.0892" height="14.67" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.45998" result="effect1_foregroundBlur"/>
</filter>
<linearGradient id="paint0_linear" x1="22.8923" y1="19.0769" x2="22.8923" y2="1825.66" gradientUnits="userSpaceOnUse">
<stop stop-color="#2A2A2C"/>
<stop offset="1" stop-color="#262627"/>
</linearGradient>
<linearGradient id="paint1_linear" x1="32.4307" y1="28.6155" x2="32.4307" y2="1816.12" gradientUnits="userSpaceOnUse">
<stop stop-color="#676767"/>
<stop offset="0.0213301"/>
<stop offset="0.978505"/>
<stop offset="1" stop-color="#676767"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="2.07416" y1="292.708" x2="4.17166" y2="292.708" gradientUnits="userSpaceOnUse">
<stop stop-color="#4E4D52"/>
<stop offset="0.00734796" stop-color="#636369"/>
<stop offset="0.903834" stop-color="#636369"/>
<stop offset="1" stop-color="#4A4950"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="2.07416" y1="452.953" x2="4.17166" y2="452.953" gradientUnits="userSpaceOnUse">
<stop stop-color="#4E4D52"/>
<stop offset="0.00734796" stop-color="#636369"/>
<stop offset="0.903834" stop-color="#636369"/>
<stop offset="1" stop-color="#4A4950"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="2.07416" y1="613.199" x2="4.17166" y2="613.199" gradientUnits="userSpaceOnUse">
<stop stop-color="#4E4D52"/>
<stop offset="0.00734796" stop-color="#636369"/>
<stop offset="0.903834" stop-color="#636369"/>
<stop offset="1" stop-color="#4A4950"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="931.179" y1="514.046" x2="931.061" y2="514.046" gradientUnits="userSpaceOnUse">
<stop stop-color="#3B3B40"/>
<stop offset="1" stop-color="#606166"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="933.815" y1="420.646" x2="933.815" y2="624.769" gradientUnits="userSpaceOnUse">
<stop stop-opacity="0.996971"/>
<stop offset="0.0951211" stop-opacity="0.01"/>
<stop offset="0.895463" stop-opacity="0.01"/>
<stop offset="1"/>
</linearGradient>
<radialGradient id="paint7_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(575.422 101.615) rotate(45.1938) scale(24.0039)">
<stop stop-color="#434343"/>
<stop offset="1" stop-color="#121212"/>
</radialGradient>
<linearGradient id="paint8_linear" x1="558.477" y1="60.0925" x2="558.477" y2="88.7078" gradientUnits="userSpaceOnUse">
<stop stop-color="#2A4893"/>
<stop offset="1" stop-color="#213054"/>
</linearGradient>
<clipPath id="clip0">
<rect width="103.015" height="2.86154" fill="white" transform="translate(415.877 1841.88)"/>
</clipPath>
<clipPath id="clip1">
<rect width="933.815" height="414.923" fill="white" transform="translate(0 251.815)"/>
</clipPath>
<clipPath id="clip2">
<rect width="106.831" height="17.1692" fill="white" transform="translate(413.015 73.4463)"/>
</clipPath>
<clipPath id="clip3">
<rect width="23.8462" height="23.8462" fill="white" transform="translate(546.554 69.6309)"/>
</clipPath>
</defs>
<path d="M173.029 0L759.833 0C802.232 0 826.945 4.77246 852.76 18.5783C877.464 31.79 897.256 51.5825 910.468 76.2861C924.274 102.101 929.046 126.815 929.046 169.213V1675.52C929.046 1717.92 924.274 1742.64 910.468 1768.45C897.256 1793.16 877.464 1812.95 852.76 1826.16C826.945 1839.97 802.232 1844.74 759.833 1844.74H173.029C130.63 1844.74 105.916 1839.97 80.1016 1826.16C55.3979 1812.95 35.6054 1793.16 22.3937 1768.45C8.58789 1742.64 3.81543 1717.92 3.81543 1675.52V169.213C3.81543 126.815 8.58789 102.101 22.3937 76.2861C35.6054 51.5825 55.3979 31.79 80.1016 18.5783C105.916 4.77246 130.63 0 173.029 0Z" fill="#58575C"/>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="3" y="0" width="927" height="1845">
<path d="M173.029 0L759.833 0C802.232 0 826.945 4.77246 852.76 18.5783C877.464 31.79 897.256 51.5825 910.468 76.2861C924.274 102.101 929.046 126.815 929.046 169.213V1675.52C929.046 1717.92 924.274 1742.64 910.468 1768.45C897.256 1793.16 877.464 1812.95 852.76 1826.16C826.945 1839.97 802.232 1844.74 759.833 1844.74H173.029C130.63 1844.74 105.916 1839.97 80.1016 1826.16C55.3979 1812.95 35.6054 1793.16 22.3937 1768.45C8.58789 1742.64 3.81543 1717.92 3.81543 1675.52V169.213C3.81543 126.815 8.58789 102.101 22.3937 76.2861C35.6054 51.5825 55.3979 31.79 80.1016 18.5783C105.916 4.77246 130.63 0 173.029 0Z" fill="white"/>
</mask>
<g mask="url(#mask0)">
<g filter="url(#filter0_ii)">
<path d="M173.029 0L759.833 0C802.232 0 826.945 4.77246 852.76 18.5783C877.464 31.79 897.256 51.5825 910.468 76.2861C924.274 102.101 929.046 126.815 929.046 169.213V1675.52C929.046 1717.92 924.274 1742.64 910.468 1768.45C897.256 1793.16 877.464 1812.95 852.76 1826.16C826.945 1839.97 802.232 1844.74 759.833 1844.74H173.029C130.63 1844.74 105.916 1839.97 80.1016 1826.16C55.3979 1812.95 35.6054 1793.16 22.3937 1768.45C8.58789 1742.64 3.81543 1717.92 3.81543 1675.52V169.213C3.81543 126.815 8.58789 102.101 22.3937 76.2861C35.6054 51.5825 55.3979 31.79 80.1016 18.5783C105.916 4.77246 130.63 0 173.029 0Z" fill="#58575C"/>
</g>
<g filter="url(#filter1_d)">
<path d="M173.029 19.0769L759.833 19.0769C799.274 19.0769 821.043 23.2494 843.763 35.4006C865.143 46.8343 882.212 63.9036 893.646 85.2828C905.797 108.004 909.969 129.772 909.969 169.213V1675.52C909.969 1714.97 905.797 1736.73 893.646 1759.46C882.212 1780.83 865.143 1797.9 843.763 1809.34C821.043 1821.49 799.274 1825.66 759.833 1825.66H173.029C133.587 1825.66 111.819 1821.49 89.0982 1809.34C67.719 1797.9 50.6497 1780.83 39.216 1759.46C27.0648 1736.73 22.8923 1714.97 22.8923 1675.52V169.213C22.8923 129.772 27.0648 108.004 39.216 85.2828C50.6497 63.9036 67.719 46.8343 89.0982 35.4006C111.819 23.2494 133.587 19.0769 173.029 19.0769Z" fill="url(#paint0_linear)"/>
</g>
<path d="M173.029 28.6155L759.833 28.6155C797.911 28.6155 818.162 32.5261 839.265 43.8118C858.982 54.3565 874.69 70.0643 885.234 89.7812C896.52 110.884 900.431 131.135 900.431 169.214V1675.53C900.431 1713.6 896.52 1733.85 885.234 1754.96C874.69 1774.67 858.982 1790.38 839.265 1800.93C818.162 1812.21 797.911 1816.12 759.833 1816.12H173.029C134.95 1816.12 114.699 1812.21 93.5964 1800.93C73.8795 1790.38 58.1717 1774.67 47.627 1754.96C36.3413 1733.85 32.4307 1713.6 32.4307 1675.53V169.214C32.4307 131.135 36.3413 110.884 47.627 89.7812C58.1717 70.0643 73.8795 54.3565 93.5964 43.8118C114.699 32.5261 134.95 28.6155 173.029 28.6155Z" fill="url(#paint1_linear)"/>
<path d="M173.029 40.0615L759.833 40.0615C797.911 40.0615 818.162 43.9221 839.265 55.0633C858.982 65.4729 874.69 80.9795 885.234 100.444C896.52 121.276 900.431 141.268 900.431 178.859V1665.88C900.431 1703.47 896.52 1723.46 885.234 1744.29C874.69 1763.76 858.982 1779.27 839.265 1789.68C818.162 1800.82 797.911 1804.68 759.833 1804.68H173.029C134.95 1804.68 114.699 1800.82 93.5964 1789.68C73.8795 1779.27 58.1717 1763.76 47.627 1744.29C36.3413 1723.46 32.4307 1703.47 32.4307 1665.88V178.859C32.4307 141.268 36.3413 121.276 47.627 100.444C58.1717 80.9795 73.8795 65.4729 93.5964 55.0633C114.699 43.9221 134.95 40.0615 173.029 40.0615Z" fill="black"/>
</g>
<g clip-path="url(#clip0)">
<g filter="url(#filter2_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M429.612 1841.88C448.155 1841.88 486.458 1841.88 505.157 1841.88C505.286 1841.88 505.414 1841.88 505.541 1841.88C510.224 1841.91 509.745 1844.74 505.061 1844.74H429.708C425.025 1844.74 424.545 1841.91 429.228 1841.88C429.355 1841.88 429.483 1841.88 429.612 1841.88Z" fill="#222222"/>
</g>
</g>
<g filter="url(#filter3_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M93.5964 1800.93C73.8795 1790.38 58.1717 1774.67 47.627 1754.96C36.3413 1733.85 32.4307 1713.6 32.4307 1675.52V169.213C32.4307 131.135 36.3413 110.883 47.627 89.7811C55.0721 75.8599 65.0911 63.9373 77.2778 54.4195C78.0728 53.7986 45.6299 78.7426 45.6299 150.137C45.6299 501.605 45.6299 1678.92 45.6299 1694.6C45.6299 1779.36 97.1024 1802.8 93.5964 1800.93Z" fill="white" fill-opacity="0.8"/>
</g>
<g filter="url(#filter4_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M839.27 1800.93C858.986 1790.38 874.694 1774.67 885.239 1754.96C896.525 1733.85 900.435 1713.6 900.435 1675.52V169.213C900.435 131.135 896.525 110.883 885.239 89.7811C877.794 75.8599 867.775 63.9373 855.588 54.4195C854.793 53.7986 887.236 78.7426 887.236 150.137C887.236 501.605 887.236 1678.92 887.236 1694.6C887.236 1779.36 835.764 1802.8 839.27 1800.93Z" fill="white" fill-opacity="0.8"/>
</g>
<rect opacity="0.602808" x="3.81543" y="181.231" width="19.0769" height="18.1231" fill="#1C1C1D"/>
<rect opacity="0.602808" x="909.969" y="181.231" width="19.0769" height="18.1231" fill="#1C1C1D"/>
<rect opacity="0.602808" x="3.81543" y="1645.38" width="19.0769" height="18.1231" fill="#1C1C1D"/>
<rect opacity="0.602808" x="909.969" y="1645.38" width="19.0769" height="18.1231" fill="#1C1C1D"/>
<g clip-path="url(#clip1)">
<g filter="url(#filter5_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M4.84276 251.815C2.16818 251.815 0 253.998 0 256.69V316.572C0 319.264 2.16818 321.446 4.84276 321.446H7.61005C7.61005 317.784 7.65667 255.396 7.61005 251.815H4.84276Z" fill="url(#paint2_linear)"/>
</g>
<g filter="url(#filter6_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M4.84276 376.769C3.26821 377.151 1.3801 378.128 0.371918 379.516C0.164257 379.802 0 380.706 0 380.967C0 394.09 0 434.059 0 500.874C0 501.153 0.231198 502.564 0.372759 502.906C1.18861 504.876 2.60616 505.353 4.84276 506.492H7.61005C7.61005 502.901 7.65667 380.28 7.61005 376.769H4.84276Z" fill="url(#paint3_linear)"/>
</g>
<g filter="url(#filter7_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M4.84276 537.015C3.26821 537.397 1.3801 538.374 0.371918 539.762C0.164257 540.048 0 540.952 0 541.214C0 554.336 0 594.305 0 661.12C0 661.4 0.231198 662.81 0.372759 663.152C1.18861 665.122 2.60616 665.599 4.84276 666.738H7.61005C7.61005 663.147 7.65667 540.526 7.61005 537.015H4.84276Z" fill="url(#paint4_linear)"/>
</g>
<g filter="url(#filter8_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M928.973 420.646C930.547 421.024 932.435 421.991 933.444 423.365C933.651 423.648 933.815 424.543 933.815 424.802C933.815 437.793 933.815 553.062 933.815 619.208C933.815 619.484 933.584 620.88 933.443 621.218C932.627 623.169 931.209 623.641 928.973 624.769H926.205C926.205 621.214 926.159 424.121 926.205 420.646H928.973Z" fill="url(#paint5_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M928.973 420.646C930.547 421.024 932.435 421.991 933.444 423.365C933.651 423.648 933.815 424.543 933.815 424.802C933.815 437.793 933.815 553.062 933.815 619.208C933.815 619.484 933.584 620.88 933.443 621.218C932.627 623.169 931.209 623.641 928.973 624.769H926.205C926.205 621.214 926.159 424.121 926.205 420.646H928.973Z" fill="url(#paint6_linear)" fill-opacity="0.4"/>
</g>
</g>
<g opacity="0.801364" clip-path="url(#clip2)">
<rect x="413.015" y="73.4463" width="106.831" height="17.1692" rx="8.58462" fill="#1D1C1C"/>
<mask id="mask1" mask-type="alpha" maskUnits="userSpaceOnUse" x="413" y="73" width="107" height="18">
<rect x="413.015" y="73.4463" width="106.831" height="17.1692" rx="8.58462" fill="white"/>
</mask>
<g mask="url(#mask1)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M413.015 73.4463H519.846V74.3499H413.015V73.4463ZM413.015 77.0608H519.846V77.9645H413.015V77.0608ZM519.846 80.6755H413.015V81.5791H519.846V80.6755ZM413.015 84.29H519.846V85.1936H413.015V84.29ZM519.846 87.9045H413.015V88.8082H519.846V87.9045Z" fill="black" fill-opacity="0.15"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M413.015 76.1572H519.846V77.0609H413.015V76.1572ZM413.015 79.7718H519.846V80.6754H413.015V79.7718ZM519.846 83.3864H413.015V84.2901H519.846V83.3864ZM413.015 87.001H519.846V87.9046H413.015V87.001ZM519.846 90.6155H413.015V91.5192H519.846V90.6155Z" fill="white" fill-opacity="0.03"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M417.443 74.2415H418.358V90.7239H417.443V74.2415ZM413.78 74.2415H414.695V90.724H413.78V74.2415ZM422.021 74.2415H421.105V90.7239H422.021V74.2415ZM423.852 74.2415H424.768V90.7239H423.852V74.2415ZM428.431 74.2415H427.515V90.7239H428.431V74.2415ZM431.178 74.2415H432.094V90.7239H431.178V74.2415ZM435.756 74.2415H434.841V90.7239H435.756V74.2415ZM437.588 74.2415H438.503V90.7239H437.588V74.2415ZM442.166 74.2415H441.25V90.7239H442.166V74.2415ZM444.913 74.2415H445.829V90.7239H444.913V74.2415ZM449.492 74.2415H448.576V90.7239H449.492V74.2415ZM451.323 74.2415H452.239V90.7239H451.323V74.2415ZM455.901 74.2415H454.986V90.7239H455.901V74.2415ZM458.649 74.2415H459.564V90.7239H458.649V74.2415ZM463.227 74.2415H462.311V90.7239H463.227V74.2415ZM465.058 74.2415H465.974V90.7239H465.058V74.2415ZM469.637 74.2415H468.721V90.7239H469.637V74.2415ZM472.384 74.2415H473.3V90.7239H472.384V74.2415ZM476.962 74.2415H476.047V90.7239H476.962V74.2415ZM478.794 74.2415H479.709V90.7239H478.794V74.2415ZM483.372 74.2415H482.457V90.7239H483.372V74.2415ZM486.119 74.2415H487.035V90.7239H486.119V74.2415ZM490.698 74.2415H489.782V90.7239H490.698V74.2415ZM492.529 74.2415H493.445V90.7239H492.529V74.2415ZM497.108 74.2415H496.192V90.7239H497.108V74.2415ZM499.855 74.2415H500.77V90.7239H499.855V74.2415ZM504.433 74.2415H503.518V90.7239H504.433V74.2415ZM506.265 74.2415H507.18V90.7239H506.265V74.2415ZM510.843 74.2415H509.927V90.7239H510.843V74.2415ZM513.59 74.2415H514.506V90.7239H513.59V74.2415ZM518.169 74.2415H517.253V90.7239H518.169V74.2415Z" fill="black" fill-opacity="0.15"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M415.616 74.2415H416.532V90.7239H415.616V74.2415ZM411.953 74.2415H412.869V90.724H411.953V74.2415ZM420.195 74.2415H419.279V90.7239H420.195V74.2415ZM422.026 74.2415H422.942V90.7239H422.026V74.2415ZM426.604 74.2415H425.689V90.7239H426.604V74.2415ZM429.352 74.2415H430.267V90.7239H429.352V74.2415ZM433.93 74.2415H433.014V90.7239H433.93V74.2415ZM435.761 74.2415H436.677V90.7239H435.761V74.2415ZM440.34 74.2415H439.424V90.7239H440.34V74.2415ZM443.087 74.2415H444.003V90.7239H443.087V74.2415ZM447.665 74.2415H446.75V90.7239H447.665V74.2415ZM449.497 74.2415H450.413V90.7239H449.497V74.2415ZM454.075 74.2415H453.16V90.7239H454.075V74.2415ZM456.822 74.2415H457.738V90.7239H456.822V74.2415ZM461.401 74.2415H460.485V90.7239H461.401V74.2415ZM463.232 74.2415H464.148V90.7239H463.232V74.2415ZM467.811 74.2415H466.895V90.7239H467.811V74.2415ZM470.558 74.2415H471.473V90.7239H470.558V74.2415ZM475.136 74.2415H474.221V90.7239H475.136V74.2415ZM476.968 74.2415H477.883V90.7239H476.968V74.2415ZM481.546 74.2415H480.63V90.7239H481.546V74.2415ZM484.293 74.2415H485.209V90.7239H484.293V74.2415ZM488.872 74.2415H487.956V90.7239H488.872V74.2415ZM490.703 74.2415H491.619V90.7239H490.703V74.2415ZM495.281 74.2415H494.366V90.7239H495.281V74.2415ZM498.029 74.2415H498.944V90.7239H498.029V74.2415ZM502.607 74.2415H501.691V90.7239H502.607V74.2415ZM504.438 74.2415H505.354V90.7239H504.438V74.2415ZM509.017 74.2415H508.101V90.7239H509.017V74.2415ZM511.764 74.2415H512.68V90.7239H511.764V74.2415ZM516.342 74.2415H515.427V90.7239H516.342V74.2415Z" fill="white" fill-opacity="0.03"/>
</g>
<g opacity="0.244441" filter="url(#filter9_iii)">
<rect x="413.015" y="73.4463" width="106.831" height="17.1692" rx="8.58462" fill="black" fill-opacity="0.01"/>
</g>
<mask id="mask2" mask-type="alpha" maskUnits="userSpaceOnUse" x="413" y="73" width="107" height="18">
<rect x="413.015" y="73.4463" width="106.831" height="17.1692" rx="8.58462" fill="white"/>
</mask>
<g mask="url(#mask2)">
</g>
</g>
<g clip-path="url(#clip3)">
<circle cx="558.477" cy="81.5539" r="11.9231" fill="url(#paint7_radial)"/>
<g opacity="0.387535" filter="url(#filter10_dd)">
<circle cx="558.477" cy="81.554" r="7.15385" fill="url(#paint8_linear)"/>
</g>
<mask id="mask3" mask-type="alpha" maskUnits="userSpaceOnUse" x="551" y="74" width="15" height="15">
<circle cx="558.477" cy="81.554" r="7.15385" fill="white"/>
</mask>
<g mask="url(#mask3)">
<g filter="url(#filter11_f)">
<ellipse cx="552.768" cy="80.6149" rx="5.91126" ry="1.98102" transform="rotate(-76 552.768 80.6149)" fill="#3E89CC"/>
</g>
<g filter="url(#filter12_f)">
<ellipse cx="563.246" cy="79.6463" rx="4.29231" ry="5.24615" fill="#1C5894"/>
</g>
<g filter="url(#filter13_f)">
<ellipse cx="559.454" cy="86.8642" rx="6.25386" ry="4.22713" transform="rotate(-16 559.454 86.8642)" fill="#0A152B"/>
</g>
</g>
</g>



</svg>
''',
    frameSize: Size(934.0, 1860.0),
    screenSize: Size(414.0, 896.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.iOS,
      DeviceType.phone,
      'iphone-se',
    ),
    name: 'iPhone SE',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 20.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 20.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          73.179,
          270.991,
          731.789,
          1298.93,
        ),
      ),
    svgFrame:
        '''<svg width="869" height="1839" viewBox="0 0 869 1839" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_ii" x="3.43027" y="580.858" width="6.86053" height="64.0316" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter1_i" x="0" y="583.28" width="3.43026" height="59.1873" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter2_ii" x="3.43027" y="431.07" width="6.86053" height="64.0316" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter3_i" x="0" y="433.492" width="3.43026" height="59.1873" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter4_i" x="3.43027" y="259.557" width="6.86053" height="83.4697" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-2.28684"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.114215 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter5_ii" x="0" y="261.979" width="3.43026" height="78.6255" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.370952 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter6_ii" x="586.575" y="3.43018" width="139.497" height="6.86053" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.157382 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.05 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter7_ii" x="588.997" y="0" width="134.653" height="3.43026" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.226619 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.06 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter8_iiiiiiii" x="21.725" y="21.7251" width="835.841" height="1791.74" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="5.71711"/>
<feGaussianBlur stdDeviation="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.228421 0 0 0 0 0.242731 0 0 0 0 0.257042 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="3.43026"/>
<feGaussianBlur stdDeviation="0.571711"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.0509804 0 0 0 0 0.0509804 0 0 0 0 0.0705882 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-5.71711"/>
<feGaussianBlur stdDeviation="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.247915 0 0 0 0 0.26952 0 0 0 0 0.286804 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-3.43026"/>
<feGaussianBlur stdDeviation="0.571711"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.0509804 0 0 0 0 0.0509804 0 0 0 0 0.0705882 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-5.71711"/>
<feGaussianBlur stdDeviation="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.08 0"/>
<feBlend mode="normal" in2="effect4_innerShadow" result="effect5_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="5.71711"/>
<feGaussianBlur stdDeviation="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.227451 0 0 0 0 0.243137 0 0 0 0 0.258824 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect5_innerShadow" result="effect6_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="3.43026"/>
<feGaussianBlur stdDeviation="0.571711"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.0509804 0 0 0 0 0.0509804 0 0 0 0 0.0705882 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect6_innerShadow" result="effect7_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-5.71711"/>
<feGaussianBlur stdDeviation="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.227451 0 0 0 0 0.243137 0 0 0 0 0.258824 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect7_innerShadow" result="effect8_innerShadow"/>
</filter>
<filter id="filter9_dii" x="858.709" y="165.796" width="10.2908" height="14.8645" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.14342"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.07 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter10_dii" x="855.279" y="165.796" width="3.43026" height="14.8645" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.14342"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.07 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter11_dii" x="10.2908" y="165.796" width="10.2908" height="14.8645" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.14342"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.07 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter12_dii" x="20.5816" y="165.796" width="3.43026" height="14.8645" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.14342"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.07 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter13_dii" x="858.709" y="1655.67" width="10.2908" height="14.8645" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.14342"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.07 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter14_dii" x="855.279" y="1655.67" width="3.43026" height="14.8645" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.14342"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.07 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter15_dii" x="10.2908" y="1655.67" width="10.2908" height="14.8645" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.14342"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.07 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter16_dii" x="20.5816" y="1655.67" width="3.43026" height="14.8645" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.14342"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.07 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter17_i" x="362.464" y="1615.65" width="156.649" height="155.505" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="1.14342"/>
<feGaussianBlur stdDeviation="0.571711"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0298064 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter18_d" x="365.895" y="158.936" width="147.501" height="20.5816" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.14342"/>
<feGaussianBlur stdDeviation="0.571711"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.36 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter19_ii" x="367.038" y="158.936" width="145.214" height="20.5816" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="2.28684" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset dy="2.28684"/>
<feGaussianBlur stdDeviation="1.71513"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.14342"/>
<feGaussianBlur stdDeviation="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter20_ii" x="367.038" y="158.936" width="145.214" height="20.5816" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="2.28684" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset dy="2.28684"/>
<feGaussianBlur stdDeviation="1.71513"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.14342"/>
<feGaussianBlur stdDeviation="1.14342"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter21_dd" x="309.867" y="156.649" width="25.1553" height="25.727" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.71513"/>
<feGaussianBlur stdDeviation="0.571711"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.06 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.14342"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
</filter>
<filter id="filter22_ddii" x="423.066" y="84.6133" width="33.1592" height="33.7309" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.71513"/>
<feGaussianBlur stdDeviation="0.571711"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.06 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.14342"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-0.914737" dy="-0.914737"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.317647 0 0 0 0 0.329412 0 0 0 0 0.333333 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-0.514539" dy="-0.514539"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.243137 0 0 0 0 0.247059 0 0 0 0 0.247059 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter23_di" x="433.357" y="93.7606" width="12.5776" height="12.5776" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="0.571711" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.285855"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.14342" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.571711"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.14902 0 0 0 0 0.364706 0 0 0 0 0.839216 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
</filter>
<filter id="filter24_d" x="432.499" y="98.6201" width="6.86053" height="6.86053" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="1.14342" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.571711"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.0941176 0 0 0 0 0.0901961 0 0 0 0 0.117647 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter25_d" x="433.929" y="100.049" width="4.00197" height="4.00197" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.571711"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.745098 0 0 0 0 0.898039 0 0 0 0 1 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter26_d" x="440.503" y="95.19" width="6.86053" height="6.86053" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="1.14342" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.571711"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.0588235 0 0 0 0 0.0705882 0 0 0 0 0.415686 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter27_d" x="441.933" y="96.6193" width="4.00197" height="4.00197" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.571711"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.0627451 0 0 0 0 0.105882 0 0 0 0 0.615686 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter28_d" x="431.473" y="90.7364" width="11.7706" height="9.47886" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="1.14342" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.571711"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.054902 0 0 0 0 0.117647 0 0 0 0 0.662745 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter29_d" x="436.047" y="101.027" width="11.7706" height="9.47886" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="1.14342" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.571711"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.14902 0 0 0 0 0.364706 0 0 0 0 0.839216 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<linearGradient id="paint0_linear" x1="3.43027" y1="580.858" x2="3.43027" y2="644.889" gradientUnits="userSpaceOnUse">
<stop stop-color="#9A9B9F"/>
<stop offset="0.11806" stop-color="#45464C"/>
<stop offset="0.259588" stop-color="#7E808A"/>
<stop offset="0.397792" stop-color="#FEFFFF"/>
<stop offset="0.516061" stop-color="#E7E9EB"/>
<stop offset="0.670811" stop-color="#7D7E83"/>
<stop offset="0.82966" stop-color="#313236"/>
<stop offset="0.891209" stop-color="#4A4B4F"/>
<stop offset="1" stop-color="#B4B5B9"/>
</linearGradient>
<linearGradient id="paint1_linear" x1="0.0299216" y1="580.858" x2="0.0299216" y2="643.772" gradientUnits="userSpaceOnUse">
<stop stop-color="#DBDDE3"/>
<stop offset="0.138343" stop-color="#B8B9BD"/>
<stop offset="0.882256" stop-color="#A0A1A3"/>
<stop offset="1" stop-color="#EDEDED"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="3.43027" y1="431.07" x2="3.43027" y2="495.101" gradientUnits="userSpaceOnUse">
<stop stop-color="#9A9B9F"/>
<stop offset="0.11806" stop-color="#45464C"/>
<stop offset="0.259588" stop-color="#7E808A"/>
<stop offset="0.397792" stop-color="#FEFFFF"/>
<stop offset="0.516061" stop-color="#E7E9EB"/>
<stop offset="0.670811" stop-color="#7D7E83"/>
<stop offset="0.82966" stop-color="#313236"/>
<stop offset="0.891209" stop-color="#4A4B4F"/>
<stop offset="1" stop-color="#B4B5B9"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="0.0299216" y1="431.07" x2="0.0299216" y2="493.984" gradientUnits="userSpaceOnUse">
<stop stop-color="#DBDDE3"/>
<stop offset="0.138343" stop-color="#B8B9BD"/>
<stop offset="0.882256" stop-color="#A0A1A3"/>
<stop offset="1" stop-color="#EDEDED"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="3.43027" y1="259.557" x2="3.43027" y2="343.026" gradientUnits="userSpaceOnUse">
<stop stop-color="#2C2D2F"/>
<stop offset="0.0451274" stop-color="#5F6062"/>
<stop offset="0.0948779" stop-color="#E1E2E8"/>
<stop offset="0.873977" stop-color="#E1E3E7"/>
<stop offset="0.942182" stop-color="#7C7D7F"/>
<stop offset="1" stop-color="#474548"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="0.0299216" y1="259.557" x2="0.0299216" y2="341.57" gradientUnits="userSpaceOnUse">
<stop stop-color="#E7E7E7"/>
<stop offset="0.0899753" stop-color="#7F8085"/>
<stop offset="0.903858" stop-color="#88898E"/>
<stop offset="1" stop-color="#E1E0E2"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="726.073" y1="3.43018" x2="586.575" y2="3.43018" gradientUnits="userSpaceOnUse">
<stop stop-color="#222325"/>
<stop offset="0.0323178" stop-color="#6E6F71"/>
<stop offset="0.0948779" stop-color="#D0D1D3"/>
<stop offset="0.211474" stop-color="#F7F8FD"/>
<stop offset="0.827861" stop-color="#F1F2F7"/>
<stop offset="0.929844" stop-color="#C0C1C6"/>
<stop offset="0.963537" stop-color="#828385"/>
<stop offset="1" stop-color="#565759"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="726.072" y1="0.0299216" x2="589.009" y2="0.0299216" gradientUnits="userSpaceOnUse">
<stop stop-color="#D9DADC"/>
<stop offset="0.0741842" stop-color="#A5A3A6"/>
<stop offset="0.918838" stop-color="#ABA8A9"/>
<stop offset="1" stop-color="#CACACF"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="10.2908" y1="10.2908" x2="10.2908" y2="1822.61" gradientUnits="userSpaceOnUse">
<stop stop-color="#BABBBF"/>
<stop offset="0.132633" stop-color="#9FA1A5"/>
<stop offset="0.646785" stop-color="#8F9195"/>
<stop offset="0.881802" stop-color="#4E4F53"/>
<stop offset="1" stop-color="#605F64"/>
</linearGradient>
<linearGradient id="paint9_linear" x1="39.8686" y1="96.1338" x2="106.549" y2="109.051" gradientUnits="userSpaceOnUse">
<stop stop-color="#48494C"/>
<stop offset="0.980808" stop-color="#48494C" stop-opacity="0.01"/>
</linearGradient>
<radialGradient id="paint10_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(869 200.237) rotate(7.37041) scale(135.3 800.797)">
<stop stop-color="#48494C"/>
<stop offset="1" stop-color="#48494C" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint11_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(733.746 -10.8804) rotate(7.08152) scale(129.885 248.667)">
<stop stop-color="#48494C"/>
<stop offset="1" stop-color="#48494C" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint12_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(816.97 1767.48) rotate(69.7499) scale(93.0155 82.9735)">
<stop stop-color="#48494C"/>
<stop offset="1" stop-color="#48494C" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint13_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(841.518 54.0668) rotate(8.41175) scale(105.368 304.986)">
<stop stop-color="#EBF0F0"/>
<stop offset="1" stop-color="#F4F7F7" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint14_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(38.8585 1745.54) rotate(5.1849) scale(131.271 292.51)">
<stop stop-color="#DEE5E5"/>
<stop offset="1" stop-color="#F4F7F7" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint15_linear" x1="20.5816" y1="20.5815" x2="20.5816" y2="1814.61" gradientUnits="userSpaceOnUse">
<stop stop-color="#DCDDE1"/>
<stop offset="0.0113028" stop-color="#8F9094"/>
<stop offset="0.0565559" stop-color="#BDBFC2"/>
<stop offset="0.68154" stop-color="#ABACB0"/>
<stop offset="0.922774" stop-color="#535458"/>
<stop offset="0.971438" stop-color="#BCBBC0"/>
<stop offset="1" stop-color="#8F8E93"/>
</linearGradient>
<radialGradient id="paint16_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(779.974 43.2177) rotate(85.0269) scale(138.496 98.1285)">
<stop stop-color="#B6B7B9"/>
<stop offset="1" stop-color="#BCBDBE" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint17_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(858.709 258.248) rotate(86.9131) scale(188.442 88.9502)">
<stop stop-color="#7C7D7F"/>
<stop offset="1" stop-color="#77787A" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint18_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(75.9705 46.3442) rotate(90) scale(124.633 58.2256)">
<stop stop-color="#737373" stop-opacity="0.804603"/>
<stop offset="1" stop-color="#787878" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint19_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(819.306 1780.54) rotate(100.055) scale(146.745 76.0403)">
<stop stop-color="#4F4F4F" stop-opacity="0.804603"/>
<stop offset="1" stop-color="#5D5D5D" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint20_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(440.217 1693.41) scale(77.7526)">
<stop offset="0.0329279" stop-color="#4D4E53"/>
<stop offset="0.110154" stop-color="#4C4D52"/>
<stop offset="0.200569" stop-color="#242227"/>
<stop offset="0.293609" stop-color="#1D1E23"/>
<stop offset="0.399026" stop-color="#575759"/>
<stop offset="0.501325" stop-color="#424348"/>
<stop offset="0.557622" stop-color="#212027"/>
<stop offset="0.629648" stop-color="#1E1D23"/>
<stop offset="0.730645" stop-color="#202026"/>
<stop offset="0.853019" stop-color="#313132"/>
<stop offset="0.937384" stop-color="#37383C"/>
</radialGradient>
<radialGradient id="paint21_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(439.645 168.083) scale(80.6112 17.1513)">
<stop offset="0.0595021" stop-color="#2F373D"/>
<stop offset="0.0994474" stop-color="#4B5155"/>
<stop offset="0.24998" stop-color="#5E6365"/>
<stop offset="0.400329" stop-color="#4B5155"/>
<stop offset="0.438602" stop-color="#2F373D"/>
<stop offset="0.747764" stop-color="#212326"/>
</radialGradient>
<radialGradient id="paint22_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(512.113 181.48) rotate(90) scale(12.2253 57.4591)">
<stop stop-color="white"/>
<stop offset="0.275126" stop-color="white"/>
<stop offset="1" stop-color="#7F7F7F" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint23_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(366.96 181.479) rotate(90) scale(12.1655 57.1777)">
<stop stop-color="white"/>
<stop offset="0.271239" stop-color="white"/>
<stop offset="1" stop-color="#7F7F7F" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint24_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(439.645 150.932) rotate(90) scale(50.6126 237.879)">
<stop stop-color="#36393F"/>
<stop offset="1" stop-color="#27282B"/>
</radialGradient>
<radialGradient id="paint25_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(330.281 177.738) rotate(47.9737) scale(20.4444)">
<stop stop-color="#1A1C1E"/>
<stop offset="1"/>
</radialGradient>
<radialGradient id="paint26_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(445.045 105.703) rotate(44.2655) scale(14.0155)">
<stop stop-color="#444647"/>
<stop offset="1" stop-color="#1B1B1B"/>
</radialGradient>
<radialGradient id="paint27_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(444.682 104.812) rotate(-65.2351) scale(15.9449 13.4939)">
<stop stop-color="#4A4D4F"/>
<stop offset="1" stop-color="#1B1B1B"/>
</radialGradient>
<radialGradient id="paint28_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(439.646 100.049) scale(7.43224)">
<stop offset="0.138891" stop-color="#222A33"/>
<stop offset="0.289339" stop-color="#394348"/>
<stop offset="0.378929" stop-color="#394348"/>
<stop offset="0.498663" stop-color="#12171E"/>
<stop offset="0.708615" stop-color="#0A121B"/>
<stop offset="0.979706" stop-color="#293236"/>
</radialGradient>
<clipPath id="clip0">
<rect width="869" height="1822.61" fill="white"/>
</clipPath>
<clipPath id="clip1">
<rect width="726.072" height="644.889" fill="white"/>
</clipPath>
<clipPath id="clip2">
<rect width="10.2908" height="64.0316" fill="white" transform="translate(0 580.858)"/>
</clipPath>
<clipPath id="clip3">
<rect width="10.2908" height="64.0316" fill="white" transform="translate(0 431.07)"/>
</clipPath>
<clipPath id="clip4">
<rect width="10.2908" height="83.4697" fill="white" transform="translate(0 259.557)"/>
</clipPath>
<clipPath id="clip5">
<rect width="10.2908" height="139.497" fill="white" transform="translate(726.072) rotate(90)"/>
</clipPath>
<clipPath id="clip6">
<rect width="858.709" height="1812.32" fill="white" transform="translate(10.2908 10.2908)"/>
</clipPath>
<clipPath id="clip7">
<rect width="838.128" height="1794.03" fill="white" transform="translate(20.5816 20.5815)"/>
</clipPath>
<clipPath id="clip8">
<rect width="858.709" height="1503.6" fill="white" transform="translate(10.2908 165.796)"/>
</clipPath>
<clipPath id="clip9">
<rect width="155.505" height="155.505" fill="white" transform="translate(362.464 1615.65)"/>
</clipPath>
<clipPath id="clip10">
<rect width="161.222" height="34.3026" fill="white" transform="translate(359.034 150.932)"/>
</clipPath>
<clipPath id="clip11">
<rect width="22.8684" height="24.0118" fill="white" transform="translate(311.01 156.649)"/>
</clipPath>
<clipPath id="clip12">
<rect width="30.8724" height="30.8724" fill="white" transform="translate(424.209 84.6133)"/>
</clipPath>
</defs>
<g clip-path="url(#clip0)">
<g clip-path="url(#clip1)">
<g clip-path="url(#clip2)">
<g filter="url(#filter0_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M3.43027 580.858H10.2908V644.889H3.43027V580.858Z" fill="url(#paint0_linear)"/>
</g>
<g filter="url(#filter1_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M0 584.999C0 584.544 0.180701 584.107 0.50235 583.786C1.58282 582.705 3.43026 583.471 3.43026 584.999V640.749C3.43026 642.277 1.58282 643.042 0.50235 641.962C0.180701 641.64 0 641.204 0 640.749V584.999Z" fill="url(#paint1_linear)"/>
</g>
</g>
<g clip-path="url(#clip3)">
<g filter="url(#filter2_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M3.43027 431.07H10.2908V495.101H3.43027V431.07Z" fill="url(#paint2_linear)"/>
</g>
<g filter="url(#filter3_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M0 435.211C0 434.756 0.180701 434.319 0.50235 433.998C1.58282 432.917 3.43026 433.682 3.43026 435.211V490.961C3.43026 492.489 1.58282 493.254 0.50235 492.173C0.180701 491.852 0 491.416 0 490.961V435.211Z" fill="url(#paint3_linear)"/>
</g>
</g>
<g clip-path="url(#clip4)">
<g filter="url(#filter4_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M3.43027 259.557H10.2908V343.026H3.43027V259.557Z" fill="url(#paint4_linear)"/>
</g>
<g filter="url(#filter5_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M0 263.697C0 263.242 0.180701 262.806 0.50235 262.485C1.58282 261.404 3.43026 262.169 3.43026 263.697V338.886C3.43026 340.414 1.58282 341.179 0.50235 340.098C0.180701 339.777 0 339.341 0 338.886V263.697Z" fill="url(#paint5_linear)"/>
</g>
</g>
<g clip-path="url(#clip5)">
<g filter="url(#filter6_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M726.073 3.43018V10.2907L586.575 10.2907V3.43018L726.073 3.43018Z" fill="url(#paint6_linear)"/>
</g>
<g filter="url(#filter7_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M721.932 0C722.387 0 722.823 0.180701 723.144 0.50235C724.225 1.58282 723.46 3.43026 721.932 3.43026L590.716 3.43026C589.188 3.43026 588.422 1.58282 589.503 0.50235C589.825 0.180701 590.261 0 590.716 0L721.932 0Z" fill="url(#paint7_linear)"/>
</g>
</g>
</g>
<g clip-path="url(#clip6)">
<rect x="10.2908" y="10.2908" width="858.709" height="1812.32" rx="125.776" fill="url(#paint8_linear)"/>
<rect x="10.2908" y="10.2908" width="858.709" height="1812.32" rx="125.776" fill="url(#paint9_linear)"/>
<rect x="10.2908" y="10.2908" width="858.709" height="1812.32" rx="125.776" fill="url(#paint10_radial)"/>
<rect x="10.2908" y="10.2908" width="858.709" height="1812.32" rx="125.776" fill="url(#paint11_radial)"/>
<rect x="10.2908" y="10.2908" width="858.709" height="1812.32" rx="125.776" fill="url(#paint12_radial)"/>
<rect x="10.2908" y="10.2908" width="858.709" height="1812.32" rx="125.776" fill="url(#paint13_radial)"/>
<rect x="10.2908" y="10.2908" width="858.709" height="1812.32" rx="125.776" fill="url(#paint14_radial)"/>
</g>
<g clip-path="url(#clip7)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M137.211 20.5815C72.7981 20.5815 20.5816 72.7981 20.5816 137.21V1697.98C20.5816 1762.39 72.7983 1814.61 137.211 1814.61H742.08C806.493 1814.61 858.709 1762.39 858.709 1697.98V137.21C858.709 72.7981 806.493 20.5815 742.08 20.5815H137.211ZM137.211 24.0118C74.6926 24.0118 24.0119 74.6926 24.0119 137.21V1697.98C24.0119 1760.5 74.6926 1811.18 137.21 1811.18H742.08C804.598 1811.18 855.279 1760.5 855.279 1697.98V137.211C855.279 74.6926 804.598 24.0118 742.08 24.0118H137.211Z" fill="url(#paint15_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M137.211 20.5815C72.7981 20.5815 20.5816 72.7981 20.5816 137.21V1697.98C20.5816 1762.39 72.7983 1814.61 137.211 1814.61H742.08C806.493 1814.61 858.709 1762.39 858.709 1697.98V137.21C858.709 72.7981 806.493 20.5815 742.08 20.5815H137.211ZM137.211 24.0118C74.6926 24.0118 24.0119 74.6926 24.0119 137.21V1697.98C24.0119 1760.5 74.6926 1811.18 137.21 1811.18H742.08C804.598 1811.18 855.279 1760.5 855.279 1697.98V137.211C855.279 74.6926 804.598 24.0118 742.08 24.0118H137.211Z" fill="url(#paint16_radial)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M137.211 20.5815C72.7981 20.5815 20.5816 72.7981 20.5816 137.21V1697.98C20.5816 1762.39 72.7983 1814.61 137.211 1814.61H742.08C806.493 1814.61 858.709 1762.39 858.709 1697.98V137.21C858.709 72.7981 806.493 20.5815 742.08 20.5815H137.211ZM137.211 24.0118C74.6926 24.0118 24.0119 74.6926 24.0119 137.21V1697.98C24.0119 1760.5 74.6926 1811.18 137.21 1811.18H742.08C804.598 1811.18 855.279 1760.5 855.279 1697.98V137.211C855.279 74.6926 804.598 24.0118 742.08 24.0118H137.211Z" fill="url(#paint17_radial)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M137.211 20.5815C72.7981 20.5815 20.5816 72.7981 20.5816 137.21V1697.98C20.5816 1762.39 72.7983 1814.61 137.211 1814.61H742.08C806.493 1814.61 858.709 1762.39 858.709 1697.98V137.21C858.709 72.7981 806.493 20.5815 742.08 20.5815H137.211ZM137.211 24.0118C74.6926 24.0118 24.0119 74.6926 24.0119 137.21V1697.98C24.0119 1760.5 74.6926 1811.18 137.21 1811.18H742.08C804.598 1811.18 855.279 1760.5 855.279 1697.98V137.211C855.279 74.6926 804.598 24.0118 742.08 24.0118H137.211Z" fill="url(#paint18_radial)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M137.211 20.5815C72.7981 20.5815 20.5816 72.7981 20.5816 137.21V1697.98C20.5816 1762.39 72.7983 1814.61 137.211 1814.61H742.08C806.493 1814.61 858.709 1762.39 858.709 1697.98V137.21C858.709 72.7981 806.493 20.5815 742.08 20.5815H137.211ZM137.211 24.0118C74.6926 24.0118 24.0119 74.6926 24.0119 137.21V1697.98C24.0119 1760.5 74.6926 1811.18 137.21 1811.18H742.08C804.598 1811.18 855.279 1760.5 855.279 1697.98V137.211C855.279 74.6926 804.598 24.0118 742.08 24.0118H137.211Z" fill="url(#paint19_radial)"/>
<g filter="url(#filter8_iiiiiiii)">
<rect x="24.0119" y="24.012" width="831.267" height="1787.17" rx="113.199" fill="#020202"/>
</g>
<rect x="24.5836" y="24.5837" width="830.124" height="1786.02" rx="112.627" stroke="#0A0A10" stroke-width="1.14342"/>
</g>
<g clip-path="url(#clip8)">
<g filter="url(#filter9_dii)">
<rect x="858.709" y="165.796" width="10.2908" height="13.7211" fill="#191B1E"/>
</g>
<g filter="url(#filter10_dii)">
<rect x="855.279" y="165.796" width="3.43026" height="13.7211" fill="#313336"/>
</g>
<g filter="url(#filter11_dii)">
<rect x="10.2908" y="165.796" width="10.2908" height="13.7211" fill="#191B1E"/>
</g>
<g filter="url(#filter12_dii)">
<rect x="20.5816" y="165.796" width="3.43026" height="13.7211" fill="#313336"/>
</g>
<g filter="url(#filter13_dii)">
<rect x="858.709" y="1655.67" width="10.2908" height="13.7211" fill="#191B1E"/>
</g>
<g filter="url(#filter14_dii)">
<rect x="855.279" y="1655.67" width="3.43026" height="13.7211" fill="#313336"/>
</g>
<g filter="url(#filter15_dii)">
<rect x="10.2908" y="1655.67" width="10.2908" height="13.7211" fill="#191B1E"/>
</g>
<g filter="url(#filter16_dii)">
<rect x="20.5816" y="1655.67" width="3.43026" height="13.7211" fill="#313336"/>
</g>
</g>
<g clip-path="url(#clip9)">
<g filter="url(#filter17_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M362.464 1693.41C362.464 1736.35 397.276 1771.16 440.217 1771.16C483.159 1771.16 517.97 1736.35 517.97 1693.41C517.97 1650.46 483.159 1615.65 440.217 1615.65C397.276 1615.65 362.464 1650.46 362.464 1693.41ZM509.966 1693.41C509.966 1731.93 478.738 1763.16 440.217 1763.16C401.696 1763.16 370.469 1731.93 370.469 1693.41C370.469 1654.89 401.696 1623.66 440.217 1623.66C478.738 1623.66 509.966 1654.89 509.966 1693.41Z" fill="url(#paint20_angular)"/>
</g>
<path opacity="0.02" d="M440.217 1763.73C479.054 1763.73 510.538 1732.24 510.538 1693.41C510.538 1654.57 479.054 1623.09 440.217 1623.09C401.38 1623.09 369.897 1654.57 369.897 1693.41C369.897 1732.24 401.38 1763.73 440.217 1763.73Z" stroke="black" stroke-width="1.14342"/>
<path opacity="0.08" d="M440.217 1770.59C397.591 1770.59 363.036 1736.03 363.036 1693.41C363.036 1650.78 397.591 1616.23 440.217 1616.23C482.843 1616.23 517.398 1650.78 517.398 1693.41C517.398 1736.03 482.843 1770.59 440.217 1770.59Z" stroke="black" stroke-width="1.14342"/>
</g>
<g opacity="0.5" clip-path="url(#clip10)">
<rect x="359.606" y="151.503" width="160.079" height="33.1592" rx="16.5796" fill="url(#paint21_angular)"/>
<rect x="359.606" y="151.503" width="160.079" height="33.1592" rx="16.5796" fill="url(#paint22_radial)"/>
<rect x="359.606" y="151.503" width="160.079" height="33.1592" rx="16.5796" fill="url(#paint23_radial)"/>
<rect x="359.606" y="151.503" width="160.079" height="33.1592" rx="16.5796" stroke="url(#paint24_radial)" stroke-width="1.14342"/>
<g filter="url(#filter18_d)">
<rect x="367.038" y="158.936" width="145.214" height="18.2947" rx="9.14737" fill="black"/>
</g>
<g filter="url(#filter19_ii)">
<rect x="367.038" y="158.936" width="145.214" height="18.2947" rx="9.14737" fill="black" fill-opacity="0.01"/>
</g>
<g filter="url(#filter20_ii)">
<rect x="367.038" y="158.936" width="145.214" height="18.2947" rx="9.14737" fill="#8F8F8F" fill-opacity="0.46"/>
</g>
</g>
<g clip-path="url(#clip11)">
<circle opacity="0.24" cx="322.445" cy="169.226" r="11.4342" fill="white"/>
<g filter="url(#filter21_dd)">
<circle cx="322.445" cy="168.083" r="11.4342" fill="url(#paint25_radial)"/>
</g>
</g>
<g clip-path="url(#clip12)">
<g filter="url(#filter22_ddii)">
<circle cx="439.645" cy="100.049" r="15.4362" fill="url(#paint26_radial)"/>
</g>
<circle cx="439.646" cy="100.837" r="12.1349" fill="url(#paint27_radial)"/>
<circle cx="439.646" cy="100.049" r="7.43224" fill="url(#paint28_angular)"/>
<g filter="url(#filter23_di)">
<circle cx="439.646" cy="100.049" r="5.14539" fill="#0D0628"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="434" y="94" width="11" height="12">
<circle cx="439.646" cy="100.049" r="5.14539" fill="white"/>
</mask>
<g mask="url(#mask0)">
<g filter="url(#filter24_d)">
<circle cx="435.93" cy="102.05" r="1.14342" fill="#18171E"/>
</g>
<g filter="url(#filter25_d)">
<circle cx="435.93" cy="102.05" r="0.857566" fill="#BEE5FF"/>
</g>
<g filter="url(#filter26_d)">
<circle cx="443.933" cy="98.6202" r="1.14342" fill="#0F126A"/>
</g>
<g filter="url(#filter27_d)">
<circle cx="443.934" cy="98.6203" r="0.857566" fill="#101B9D"/>
</g>
<g filter="url(#filter28_d)">
<ellipse cx="437.359" cy="95.4757" rx="4.00197" ry="1.71513" transform="rotate(-29 437.359 95.4757)" fill="#0E1EA9"/>
</g>
<g filter="url(#filter29_d)">
<ellipse cx="441.932" cy="105.766" rx="4.00197" ry="1.71513" transform="rotate(-29 441.932 105.766)" fill="#265DD6"/>
</g>
</g>
</g>
<rect x="64.0316" y="261.844" width="750.084" height="1317.22" rx="6.86053" fill="#222222"/>
</g>



</svg>
''',
    frameSize: Size(869.0, 1839.0),
    screenSize: Size(320.0, 568.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.android,
      DeviceType.phone,
      'small',
    ),
    name: 'Small Phone',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          15.6769,
          52.4312,
          320.0,
          569.0,
        ),
      ),
    svgFrame:
        '''<svg width="354" height="662" viewBox="0 0 354 662" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_i" x="0" y="0" width="350.457" height="661.5" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.295246"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter1_iiii" x="3.24765" y="3.55127" width="344.847" height="657.168" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.295246"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0.35 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.442869"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.295246"/>
<feGaussianBlur stdDeviation="0.147623"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.295246"/>
<feGaussianBlur stdDeviation="0.442869"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter2_f" x="5.59429" y="9.58269" width="24.8699" height="639.185" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.401281" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter3_f" x="317.197" y="8.19744" width="28.6051" height="640.605" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.401281" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter4_iii" x="350.162" y="116.976" width="5.60967" height="52.2585" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.590492" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset dx="0.885738"/>
<feGaussianBlur stdDeviation="0.147623"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.24 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.590492" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dx="2.36197"/>
<feGaussianBlur stdDeviation="0.590492"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.24 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-0.590492"/>
<feGaussianBlur stdDeviation="0.147623"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.12 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter5_ii" x="350.162" y="186.836" width="4.42869" height="104.222" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="1.77148"/>
<feGaussianBlur stdDeviation="0.295246"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-0.885738"/>
<feGaussianBlur stdDeviation="0.147623"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter6_diii" x="134" y="26.7048" width="81.7831" height="10.3336" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.295246"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.590492" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="-0.295246"/>
<feGaussianBlur stdDeviation="0.442869"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.295246" operator="erode" in="SourceAlpha" result="effect3_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.295246"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.295246"/>
<feGaussianBlur stdDeviation="0.442869"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter7_diii" x="151" y="637.794" width="48" height="7.61733" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.205776"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.205776" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="0.411552"/>
<feGaussianBlur stdDeviation="0.308664"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.205776" operator="erode" in="SourceAlpha" result="effect3_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.205776"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.205776"/>
<feGaussianBlur stdDeviation="0.308664"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter8_f" x="109.624" y="29.593" width="11.7396" height="11.335" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.28528" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter9_f" x="113.632" y="33.6528" width="4.15178" height="4.04885" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.32132" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter10_f" x="107.236" y="25.54" width="5.55295" height="4.75952" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.32132" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter11_d" x="105.764" y="24.7636" width="13.9484" height="13.9484" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.118207"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter12_f" x="108.97" y="27.0248" width="4.79516" height="4.73312" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.642639" result="effect1_foregroundBlur"/>
</filter>
<radialGradient id="paint0_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(183.189 330.75) rotate(90) scale(380.902 201.799)">
<stop stop-color="#1E1E1E"/>
<stop offset="1" stop-color="#0A0A0A"/>
</radialGradient>
<linearGradient id="paint1_linear" x1="7.2495" y1="488.812" x2="35.486" y2="488.812" gradientUnits="userSpaceOnUse">
<stop stop-color="#EEEEEE" stop-opacity="0.855101"/>
<stop offset="1" stop-color="#D8D8D8" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="6.39685" y1="10.3853" x2="6.39685" y2="647.965" gradientUnits="userSpaceOnUse">
<stop stop-color="#686868"/>
<stop offset="0.019851" stop-color="#C6C6C6"/>
<stop offset="0.0526644" stop-color="#E4E4E4"/>
<stop offset="0.787327" stop-color="#D0D0D0"/>
<stop offset="0.939455" stop-color="#C5C5C5"/>
<stop offset="0.954674" stop-color="white"/>
<stop offset="0.98365" stop-color="#ADADAD"/>
<stop offset="1" stop-color="#D8D8D8"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="319.65" y1="404.716" x2="346.918" y2="404.716" gradientUnits="userSpaceOnUse">
<stop stop-color="#EEEEEE" stop-opacity="0.01"/>
<stop offset="0.794113" stop-color="#E0E0E0" stop-opacity="0.525957"/>
<stop offset="0.833895" stop-color="#E1E1E1" stop-opacity="0.508693"/>
<stop offset="1" stop-color="#D8D8D8"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="322.797" y1="9" x2="322.797" y2="648" gradientUnits="userSpaceOnUse">
<stop stop-color="#8C8A8D"/>
<stop offset="0.0244456" stop-color="#747474"/>
<stop offset="0.0611492" stop-color="#949494"/>
<stop offset="0.0915986" stop-color="#BFBFBF"/>
<stop offset="0.14244" stop-color="#ADADAD"/>
<stop offset="0.348646" stop-color="#8B8B8B"/>
<stop offset="0.402614" stop-color="#595F58"/>
<stop offset="0.55256" stop-color="#6D6F6F"/>
<stop offset="0.736922" stop-color="#606660"/>
<stop offset="0.88443" stop-color="#EAEAEA"/>
<stop offset="0.944479" stop-color="#B5B5B5"/>
<stop offset="0.988288" stop-color="#6B6B6B"/>
<stop offset="1" stop-color="#4F4D4D"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="350.457" y1="116.976" x2="350.457" y2="169.235" gradientUnits="userSpaceOnUse">
<stop stop-color="#373737"/>
<stop offset="0.0307924" stop-color="#4C4C4C"/>
<stop offset="0.0685746" stop-color="#363636"/>
<stop offset="0.916235" stop-color="#3D3D3D"/>
<stop offset="0.971221" stop-color="#202020"/>
<stop offset="1" stop-color="#767676"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="350.457" y1="186.836" x2="350.457" y2="291.058" gradientUnits="userSpaceOnUse">
<stop stop-color="#505050"/>
<stop offset="0.0134163" stop-color="#B3B3B3"/>
<stop offset="0.0412327" stop-color="#212121"/>
<stop offset="0.110692" stop-color="#242424"/>
<stop offset="0.876962" stop-color="#191919"/>
<stop offset="0.957457" stop-color="#2A2A2A"/>
<stop offset="1" stop-color="#212121"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="215.783" y1="36.7431" x2="215.783" y2="27" gradientUnits="userSpaceOnUse">
<stop stop-color="#313131"/>
<stop offset="0.521857" stop-color="#2E2E2E"/>
<stop offset="1" stop-color="#282727"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="199" y1="645" x2="199" y2="638" gradientUnits="userSpaceOnUse">
<stop stop-color="#313131"/>
<stop offset="0.521857" stop-color="#2E2E2E"/>
<stop offset="1" stop-color="#282727"/>
</linearGradient>
<radialGradient id="paint9_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(115.47 35.2248) scale(3.32314 3.13248)">
<stop stop-color="#394B90"/>
<stop offset="0.154352" stop-color="#414A7C"/>
<stop offset="0.377408" stop-color="#293A81"/>
<stop offset="0.646932" stop-color="#37498E"/>
<stop offset="0.900234" stop-color="#24357E"/>
<stop offset="1" stop-color="#485491"/>
</radialGradient>
<radialGradient id="paint10_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(115.708 35.6772) rotate(90) scale(2.35852 2.44637)">
<stop stop-color="#EEEEEE"/>
<stop offset="0.268157" stop-color="#E8E8E8" stop-opacity="0.573454"/>
<stop offset="1" stop-color="#D8D8D8" stop-opacity="0.122877"/>
</radialGradient>
<radialGradient id="paint11_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(112.738 31.7378) scale(6.73779)">
<stop offset="0.147774" stop-color="#231E1B"/>
<stop offset="0.379161" stop-color="#5F5F5F" stop-opacity="0.210456"/>
<stop offset="0.62265" stop-opacity="0.280797"/>
<stop offset="0.882483" stop-opacity="0.374321"/>
</radialGradient>
</defs>
<g filter="url(#filter0_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M305.784 0H45.4765C25.6744 0 0 12.6686 0 45.8035V616.98C0 632.01 8.50159 661.5 42.8431 661.5H154.682C155.505 660.89 156.969 660 158.508 660H192.374C193.729 660 195.097 660.89 195.875 661.5H305.784C340.431 661.5 350.457 633.353 350.457 618.825V44.4706C350.457 25.9378 339.503 0 305.784 0Z" fill="url(#paint0_radial)"/>
</g>
<g filter="url(#filter1_iiii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M45.4355 3.55127C57.3681 3.55127 146.091 3.55127 304.919 3.55127C338.455 3.55127 348.095 28.5445 348.095 46.9238C348.095 58.7607 348.095 196.197 348.095 620.5C348.095 634.908 339.01 660.424 304.919 660.424C297.778 660.424 207.048 660.424 45.4355 660.424C11.6437 660.424 3.24765 633.464 3.24765 618.559C3.24765 204.301 3.24765 68.0637 3.24765 46.9238C3.24765 14.0633 25.9504 3.55127 45.4355 3.55127Z" fill="black"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="0" y="10" width="57" height="638">
<rect y="10.3335" width="56.392" height="637.667" fill="url(#paint1_linear)"/>
</mask>
<g mask="url(#mask0)">
<g filter="url(#filter2_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M26.3801 647.965C26.3801 647.965 23.9408 645.95 21.0725 644.295C15.7129 641.202 14.3226 637.666 13.1426 636.199C10.4254 632.822 8.4383 627.969 8.09375 622.843C7.74921 617.717 8.09375 50.2793 8.09375 50.2793C8.09375 50.2793 8.09375 36.82 8.74331 33.3258C9.39286 29.8317 9.82047 28.3137 12.2452 24.0363C14.67 19.7589 17.1272 17.4722 19.3821 15.7317C22.085 13.6456 29.6616 10.3853 29.6616 10.3853C29.6616 10.3853 21.9726 12.7708 18.4278 15.1847C15.5914 17.1161 11.289 21.9044 8.74331 27.9479C7.27969 31.4226 6.59687 35.9977 6.59687 39.5523C6.59687 49.2892 6.14683 616.554 6.59687 621.919C7.04691 627.285 8.29097 630.825 10.7447 634.265C12.074 636.128 13.4824 639.703 17.328 642.618C20.5812 645.084 26.3801 647.965 26.3801 647.965Z" fill="url(#paint2_linear)"/>
</g>
</g>
<mask id="mask1" mask-type="alpha" maskUnits="userSpaceOnUse" x="303" y="9" width="43" height="651">
<path d="M303 9H346V660H303V9Z" fill="url(#paint3_linear)"/>
</mask>
<g mask="url(#mask1)">
<g filter="url(#filter3_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M318 9C318 9 324.355 11.497 326.798 12.8331C330.983 15.122 333.736 17.6015 334.664 18.4939C336.868 20.6138 339.844 24.3769 341.542 28.8782C342.984 32.7023 343.081 37.1729 343.081 42.0442C343.081 52.6496 343.081 614.09 343.081 614.09C343.081 614.09 343.721 626.861 340.338 633.354C338.524 636.834 338.801 637.772 335.844 640.925C332.638 644.343 329.169 648 329.169 648C329.169 648 337.382 641.65 338.581 639.962C339.516 638.646 341.886 634.44 343.289 631.029C345.034 626.789 345 621.224 345 618.809C345 614.45 344.551 39.9219 344.551 35.3107C344.551 30.6995 340.887 23.1764 337.621 19.72C334.355 16.2636 330.388 12.8944 326.798 11.2823C323.208 9.67016 318 9 318 9Z" fill="url(#paint4_linear)"/>
</g>
</g>
<g filter="url(#filter4_iii)">
<path d="M350.457 116.976H352.228C353.207 116.976 354 117.769 354 118.748V167.463C354 168.441 353.207 169.235 352.228 169.235H350.457V116.976Z" fill="url(#paint5_linear)"/>
</g>
<g filter="url(#filter5_ii)">
<path d="M350.457 186.836H352.228C353.207 186.836 354 187.629 354 188.607V289.286C354 290.265 353.207 291.058 352.228 291.058H350.457V186.836Z" fill="url(#paint6_linear)"/>
</g>
<g filter="url(#filter6_diii)">
<rect x="134" y="27" width="81.7831" height="9.74312" rx="4.87156" fill="url(#paint7_linear)"/>
</g>
<g filter="url(#filter7_diii)">
<rect x="151" y="638" width="48" height="7" rx="3.39531" fill="url(#paint8_linear)"/>
</g>
<g filter="url(#filter8_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M112.278 38.3573C112.278 38.3573 111.748 34.0117 113.362 32.7321C114.976 31.4525 118.793 32.7321 118.793 32.7321C118.793 32.7321 117.153 35.1757 115.904 36.3103C114.656 37.445 112.278 38.3573 112.278 38.3573Z" fill="url(#paint9_angular)"/>
</g>
<g filter="url(#filter9_f)">
<ellipse cx="115.708" cy="35.6772" rx="1.43325" ry="1.38179" fill="url(#paint10_radial)" fill-opacity="0.2"/>
</g>
<g filter="url(#filter10_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M112.147 26.1825C112.147 26.1825 110.481 26.9995 109.614 27.7192C108.748 28.4389 107.879 29.6567 107.879 29.6567C107.879 29.6567 108.197 28.0986 108.982 27.3742C109.767 26.6498 112.147 26.1825 112.147 26.1825Z" fill="#D8D8D8" fill-opacity="0.5"/>
</g>
<g filter="url(#filter11_d)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M112.738 38.4756C116.459 38.4756 119.476 35.459 119.476 31.7378C119.476 28.0166 116.459 25 112.738 25C109.017 25 106 28.0166 106 31.7378C106 35.459 109.017 38.4756 112.738 38.4756ZM112.738 37.2938C115.806 37.2938 118.293 34.8064 118.293 31.7381C118.293 28.6697 115.806 26.1823 112.738 26.1823C109.669 26.1823 107.182 28.6697 107.182 31.7381C107.182 34.8064 109.669 37.2938 112.738 37.2938Z" fill="url(#paint11_angular)"/>
</g>
<g filter="url(#filter12_f)">
<ellipse cx="111.368" cy="29.3913" rx="1.1123" ry="1.08128" fill="white"/>
</g>



</svg>
''',
    frameSize: Size(354.0, 662.0),
    screenSize: Size(320.0, 569.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.android,
      DeviceType.phone,
      'medium',
    ),
    name: 'Medium Phone',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          23.0,
          70.0,
          411.0,
          731.0,
        ),
      ),
    svgFrame:
        '''<svg width="458" height="855" viewBox="0 0 458 855" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_i" x="0" y="0" width="452.629" height="854.354" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.381322"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter1_iiii" x="4.19446" y="4.58643" width="445.384" height="848.76" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.381322"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0.35 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.571983"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.381322"/>
<feGaussianBlur stdDeviation="0.190661"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.381322"/>
<feGaussianBlur stdDeviation="0.571983"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter2_f" x="7.2253" y="12.3761" width="32.1205" height="825.533" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.518271" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter3_f" x="409.674" y="10.587" width="36.9447" height="827.368" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.518271" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter4_iii" x="452.248" y="151.079" width="7.24512" height="67.494" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.762644" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset dx="1.14397"/>
<feGaussianBlur stdDeviation="0.190661"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.24 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.762644" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dx="3.05058"/>
<feGaussianBlur stdDeviation="0.762644"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.24 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-0.762644"/>
<feGaussianBlur stdDeviation="0.190661"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.12 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter5_ii" x="452.248" y="241.306" width="5.71983" height="134.607" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="2.28793"/>
<feGaussianBlur stdDeviation="0.381322"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.14397"/>
<feGaussianBlur stdDeviation="0.190661"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter6_diii" x="187.759" y="36.3459" width="76.2407" height="9.6333" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.275237"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.550474" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="-0.275237"/>
<feGaussianBlur stdDeviation="0.412856"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.275237" operator="erode" in="SourceAlpha" result="effect3_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.275237"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.275237"/>
<feGaussianBlur stdDeviation="0.412856"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter7_diii" x="195.023" y="823.737" width="61.994" height="9.83809" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.265768"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.265768" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="0.531537"/>
<feGaussianBlur stdDeviation="0.398652"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.265768" operator="erode" in="SourceAlpha" result="effect3_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.265768"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.265768"/>
<feGaussianBlur stdDeviation="0.398652"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter8_f" x="166.366" y="38.7595" width="12.2127" height="11.7917" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.33707" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter9_f" x="170.535" y="42.9828" width="4.31907" height="4.212" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.334267" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter10_f" x="163.882" y="34.5429" width="5.77671" height="4.9513" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.334267" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter11_d" x="162.35" y="33.7355" width="14.5105" height="14.5105" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.12297"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter12_f" x="165.686" y="36.0872" width="4.98838" height="4.92384" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.668534" result="effect1_foregroundBlur"/>
</filter>
<radialGradient id="paint0_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(236.596 427.177) rotate(90) scale(491.95 260.631)">
<stop stop-color="#1E1E1E"/>
<stop offset="1" stop-color="#0A0A0A"/>
</radialGradient>
<linearGradient id="paint1_linear" x1="9.36302" y1="631.32" x2="45.8316" y2="631.32" gradientUnits="userSpaceOnUse">
<stop stop-color="#EEEEEE" stop-opacity="0.855101"/>
<stop offset="1" stop-color="#D8D8D8" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="8.26184" y1="13.4126" x2="8.26184" y2="836.873" gradientUnits="userSpaceOnUse">
<stop stop-color="#686868"/>
<stop offset="0.019851" stop-color="#C6C6C6"/>
<stop offset="0.0526644" stop-color="#E4E4E4"/>
<stop offset="0.787327" stop-color="#D0D0D0"/>
<stop offset="0.939455" stop-color="#C5C5C5"/>
<stop offset="0.954674" stop-color="white"/>
<stop offset="0.98365" stop-color="#ADADAD"/>
<stop offset="1" stop-color="#D8D8D8"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="412.841" y1="522.707" x2="448.058" y2="522.707" gradientUnits="userSpaceOnUse">
<stop stop-color="#EEEEEE" stop-opacity="0.01"/>
<stop offset="0.794113" stop-color="#E0E0E0" stop-opacity="0.525957"/>
<stop offset="0.833895" stop-color="#E1E1E1" stop-opacity="0.508693"/>
<stop offset="1" stop-color="#D8D8D8"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="416.905" y1="11.6235" x2="416.905" y2="836.918" gradientUnits="userSpaceOnUse">
<stop stop-color="#8C8A8D"/>
<stop offset="0.0244456" stop-color="#747474"/>
<stop offset="0.0611492" stop-color="#949494"/>
<stop offset="0.0915986" stop-color="#BFBFBF"/>
<stop offset="0.14244" stop-color="#ADADAD"/>
<stop offset="0.348646" stop-color="#8B8B8B"/>
<stop offset="0.402614" stop-color="#595F58"/>
<stop offset="0.55256" stop-color="#6D6F6F"/>
<stop offset="0.736922" stop-color="#606660"/>
<stop offset="0.88443" stop-color="#EAEAEA"/>
<stop offset="0.944479" stop-color="#B5B5B5"/>
<stop offset="0.988288" stop-color="#6B6B6B"/>
<stop offset="1" stop-color="#4F4D4D"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="452.63" y1="151.079" x2="452.63" y2="218.573" gradientUnits="userSpaceOnUse">
<stop stop-color="#373737"/>
<stop offset="0.0307924" stop-color="#4C4C4C"/>
<stop offset="0.0685746" stop-color="#363636"/>
<stop offset="0.916235" stop-color="#3D3D3D"/>
<stop offset="0.971221" stop-color="#202020"/>
<stop offset="1" stop-color="#767676"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="452.63" y1="241.306" x2="452.63" y2="375.913" gradientUnits="userSpaceOnUse">
<stop stop-color="#505050"/>
<stop offset="0.0134163" stop-color="#B3B3B3"/>
<stop offset="0.0412327" stop-color="#212121"/>
<stop offset="0.110692" stop-color="#242424"/>
<stop offset="0.876962" stop-color="#191919"/>
<stop offset="0.957457" stop-color="#2A2A2A"/>
<stop offset="1" stop-color="#212121"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="76.2407" y1="9.08283" x2="76.2407" y2="0" gradientUnits="userSpaceOnUse">
<stop stop-color="#313131"/>
<stop offset="0.521857" stop-color="#2E2E2E"/>
<stop offset="1" stop-color="#282727"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="257.017" y1="833.043" x2="257.017" y2="824.002" gradientUnits="userSpaceOnUse">
<stop stop-color="#313131"/>
<stop offset="0.521857" stop-color="#2E2E2E"/>
<stop offset="1" stop-color="#282727"/>
</linearGradient>
<radialGradient id="paint9_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(172.448 44.6186) scale(3.45705 3.2587)">
<stop stop-color="#394B90"/>
<stop offset="0.154352" stop-color="#414A7C"/>
<stop offset="0.377408" stop-color="#293A81"/>
<stop offset="0.646932" stop-color="#37498E"/>
<stop offset="0.900234" stop-color="#24357E"/>
<stop offset="1" stop-color="#485491"/>
</radialGradient>
<radialGradient id="paint10_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(172.695 45.0888) rotate(90) scale(2.45356 2.54494)">
<stop stop-color="#EEEEEE"/>
<stop offset="0.268157" stop-color="#E8E8E8" stop-opacity="0.573454"/>
<stop offset="1" stop-color="#D8D8D8" stop-opacity="0.122877"/>
</radialGradient>
<radialGradient id="paint11_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(169.606 40.9907) scale(7.00929)">
<stop offset="0.147774" stop-color="#231E1B"/>
<stop offset="0.379161" stop-color="#5F5F5F" stop-opacity="0.210456"/>
<stop offset="0.62265" stop-opacity="0.280797"/>
<stop offset="0.882483" stop-opacity="0.374321"/>
</radialGradient>
</defs>
<g filter="url(#filter0_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M394.933 0H58.7348C33.1596 0 0 16.362 0 59.157V796.855C0 816.266 10.9801 854.354 55.3336 854.354H199.778C200.84 853.567 202.731 852.417 204.719 852.417H248.459C250.21 852.417 251.977 853.567 252.981 854.354H394.933C439.68 854.354 452.629 818.002 452.629 799.238V57.4356C452.629 33.4997 438.482 0 394.933 0Z" fill="url(#paint0_radial)"/>
</g>
<g filter="url(#filter1_iiii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M58.6818 4.58643C74.0933 4.58643 188.683 4.58643 393.815 4.58643C437.128 4.58643 449.579 36.8662 449.579 60.6038C449.579 75.8917 449.579 253.397 449.579 801.401C449.579 820.009 437.846 852.965 393.815 852.965C384.593 852.965 267.411 852.965 58.6818 852.965C15.0383 852.965 4.19446 818.145 4.19446 798.894C4.19446 263.863 4.19446 87.9068 4.19446 60.6038C4.19446 18.1632 33.516 4.58643 58.6818 4.58643Z" fill="black"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="0" y="13" width="73" height="824">
<rect y="13.3457" width="72.8325" height="823.572" fill="url(#paint1_linear)"/>
</mask>
<g mask="url(#mask0)">
<g filter="url(#filter2_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M34.0711 836.873C34.0711 836.873 30.9206 834.27 27.2161 832.133C20.2939 828.139 18.4983 823.572 16.9743 821.677C13.4649 817.315 10.8985 811.048 10.4535 804.427C10.0085 797.806 10.4535 64.9374 10.4535 64.9374C10.4535 64.9374 10.4535 47.5541 11.2924 43.0413C12.1313 38.5285 12.6836 36.5679 15.8153 31.0435C18.9469 25.519 22.1205 22.5656 25.0329 20.3178C28.5237 17.6234 38.3093 13.4126 38.3093 13.4126C38.3093 13.4126 28.3786 16.4936 23.8002 19.6113C20.137 22.1058 14.5802 28.29 11.2924 36.0955C9.40206 40.5832 8.52017 46.4921 8.52017 51.083C8.52017 63.6587 7.93892 796.304 8.52017 803.234C9.10142 810.163 10.7082 814.736 13.8773 819.178C15.5941 821.585 17.4131 826.202 22.3799 829.967C26.5815 833.152 34.0711 836.873 34.0711 836.873Z" fill="url(#paint2_linear)"/>
</g>
</g>
<mask id="mask1" mask-type="alpha" maskUnits="userSpaceOnUse" x="391" y="11" width="56" height="842">
<path d="M391.337 11.6235H446.873V852.417H391.337V11.6235Z" fill="url(#paint3_linear)"/>
</mask>
<g mask="url(#mask1)">
<g filter="url(#filter3_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M410.71 11.6235C410.71 11.6235 418.917 14.8485 422.073 16.5741C427.478 19.5303 431.034 22.7328 432.232 23.8853C435.078 26.6233 438.923 31.4834 441.116 37.2971C442.978 42.236 443.103 48.0099 443.103 54.3014C443.103 67.9987 443.103 793.122 443.103 793.122C443.103 793.122 443.929 809.617 439.56 818.002C437.218 822.497 437.576 823.709 433.756 827.781C429.616 832.195 425.135 836.918 425.135 836.918C425.135 836.918 435.743 828.717 437.292 826.536C438.499 824.837 441.56 819.405 443.372 815C445.626 809.523 445.582 802.336 445.582 799.216C445.582 793.587 445.002 51.5604 445.002 45.6049C445.002 39.6493 440.27 29.933 436.052 25.4689C431.833 21.0047 426.709 16.6533 422.073 14.5712C417.436 12.4891 410.71 11.6235 410.71 11.6235Z" fill="url(#paint4_linear)"/>
</g>
</g>
<g filter="url(#filter4_iii)">
<path d="M452.63 151.079H454.917C456.181 151.079 457.205 152.103 457.205 153.367V216.285C457.205 217.549 456.181 218.573 454.917 218.573H452.63V151.079Z" fill="url(#paint5_linear)"/>
</g>
<g filter="url(#filter5_ii)">
<path d="M452.63 241.306H454.917C456.181 241.306 457.205 242.33 457.205 243.594V373.625C457.205 374.889 456.181 375.913 454.917 375.913H452.63V241.306Z" fill="url(#paint6_linear)"/>
</g>
<g filter="url(#filter6_diii)">
<rect width="76.2407" height="9.08283" rx="4.54141" transform="matrix(1 0 0 -1 187.759 45.7041)" fill="url(#paint7_linear)"/>
</g>
<g filter="url(#filter7_diii)">
<rect x="195.023" y="824.002" width="61.994" height="9.04079" rx="4.38518" fill="url(#paint8_linear)"/>
</g>
<g filter="url(#filter8_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M169.127 47.8773C169.127 47.8773 168.575 43.3566 170.254 42.0254C171.933 40.6943 175.905 42.0254 175.905 42.0254C175.905 42.0254 174.198 44.5675 172.899 45.7479C171.6 46.9282 169.127 47.8773 169.127 47.8773Z" fill="url(#paint9_angular)"/>
</g>
<g filter="url(#filter9_f)">
<ellipse cx="172.695" cy="45.0888" rx="1.491" ry="1.43746" fill="url(#paint10_radial)" fill-opacity="0.2"/>
</g>
<g filter="url(#filter10_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M168.99 35.2115C168.99 35.2115 167.258 36.0614 166.356 36.8101C165.454 37.5588 164.551 38.8257 164.551 38.8257C164.551 38.8257 164.881 37.2047 165.698 36.4512C166.515 35.6976 168.99 35.2115 168.99 35.2115Z" fill="#D8D8D8" fill-opacity="0.5"/>
</g>
<g filter="url(#filter11_d)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M169.606 48C173.477 48 176.615 44.8619 176.615 40.9907C176.615 37.1196 173.477 33.9814 169.606 33.9814C165.734 33.9814 162.596 37.1196 162.596 40.9907C162.596 44.8619 165.734 48 169.606 48ZM169.606 46.7704C172.797 46.7704 175.385 44.1828 175.385 40.9908C175.385 37.7989 172.797 35.2113 169.606 35.2113C166.414 35.2113 163.826 37.7989 163.826 40.9908C163.826 44.1828 166.414 46.7704 169.606 46.7704Z" fill="url(#paint11_angular)"/>
</g>
<g filter="url(#filter12_f)">
<ellipse cx="168.18" cy="38.5492" rx="1.15712" ry="1.12485" fill="white"/>
</g>



</svg>
''',
    frameSize: Size(458.0, 855.0),
    screenSize: Size(411.0, 731.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.android,
      DeviceType.phone,
      'samsung-s20',
    ),
    name: 'Samsung Galaxy S20',
    pixelRatio: 4.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 48.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 48.0,
      top: 24.0,
      right: 48.0,
      bottom: 0.0,
    ),
    screenPath: parseSvgPathData(
        'M34.1774 78.1597C25.0542 96.065 25.0542 119.504 25.0542 166.383V1717.01C25.0542 1765.17 25.0542 1789.25 34.4256 1807.64C42.669 1823.82 55.8225 1836.97 72.001 1845.21C90.3935 1854.59 114.471 1854.59 162.625 1854.59H707.441C755.596 1854.59 779.673 1854.59 798.065 1845.21C814.244 1836.97 827.397 1823.82 835.641 1807.64C845.012 1789.25 845.012 1765.17 845.012 1717.01V166.383C845.012 119.504 845.012 96.065 835.889 78.1597C827.864 62.4098 815.059 49.6047 799.309 41.5797C781.404 32.4565 757.964 32.4565 711.086 32.4565H158.981C112.102 32.4565 88.6627 32.4565 70.7574 41.5797C55.0075 49.6047 42.2024 62.4098 34.1774 78.1597ZM435.033 95.6618C447.612 95.6618 457.81 85.4643 457.81 72.8852C457.81 60.306 447.612 50.1085 435.033 50.1085C422.454 50.1085 412.257 60.306 412.257 72.8852C412.257 85.4643 422.454 95.6618 435.033 95.6618Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="876" height="1899" viewBox="0 0 876 1899" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_f" x="871.935" y="730.151" width="4.80391" height="152.282" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.773916" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter1_f" x="853.377" y="727.536" width="36.7953" height="28.254" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="4.64349" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter2_f" x="853.377" y="855.655" width="36.7953" height="28.254" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="4.64349" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter3_f" x="870.956" y="354.497" width="9.0384" height="287.112" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.54783" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter4_f" x="853.377" y="354.669" width="36.7953" height="36.7953" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="4.64349" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter5_f" x="853.377" y="604.073" width="36.7953" height="36.7953" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="4.64349" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter6_i" x="0" y="0" width="870.067" height="1899" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.13883" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.70825"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.287422 0 0 0 0 0.287422 0 0 0 0 0.297243 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter7_d" x="3.98601" y="9.67986" width="862.095" height="1881.92" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="1.70825" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.284708"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter8_di" x="420.798" y="58.6499" width="28.4708" height="28.4708" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="11.9577" operator="erode" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="37.012"/>
<feGaussianBlur stdDeviation="0.854123"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
</filter>
<filter id="filter9_di" x="425.923" y="63.7743" width="18.2213" height="18.2213" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="0.569415" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.13883" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="0.569415"/>
<feGaussianBlur stdDeviation="0.854123"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
</filter>
<filter id="filter10_f" x="422.982" y="61.4029" width="24.103" height="24.103" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.47044" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter11_f" x="423.557" y="58.5616" width="22.953" height="16.12" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="2.32175" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter12_f" x="427.537" y="76.208" width="14.423" height="11.0065" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.47044" result="effect1_foregroundBlur"/>
</filter>
<linearGradient id="paint0_linear" x1="6.26367" y1="11.9575" x2="6.26367" y2="1889.32" gradientUnits="userSpaceOnUse">
<stop stop-color="#010101"/>
<stop offset="0.989632"/>
<stop offset="1" stop-color="#4A4A4A"/>
</linearGradient>
<radialGradient id="paint1_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(435.033 950.639) scale(428.77 938.681)">
<stop stop-color="#0C0C0C"/>
<stop offset="0.140563" stop-color="#0B0B0B"/>
<stop offset="0.232695" stop-color="#111111"/>
<stop offset="0.37144" stop-color="#1A1A1A"/>
<stop offset="0.66137" stop-color="#2E2E2E"/>
<stop offset="0.675413" stop-color="#020202"/>
<stop offset="0.710915" stop-color="#474747"/>
<stop offset="0.753225" stop-color="#2A2A2A"/>
<stop offset="0.78617" stop-color="#2B2B2B"/>
<stop offset="0.843604" stop-color="#060606"/>
<stop offset="0.898025" stop-color="#050505"/>
</radialGradient>
<linearGradient id="paint2_linear" x1="6.26367" y1="11.9575" x2="6.26367" y2="1889.32" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.01"/>
<stop offset="0.0231241" stop-color="#FDFDFD" stop-opacity="0.01"/>
<stop offset="0.34104" stop-color="#959595" stop-opacity="0.01"/>
<stop offset="0.762428" stop-color="#121112" stop-opacity="0.01"/>
<stop offset="0.977144" stop-color="#0A0A0A"/>
<stop offset="1" stop-color="#48484B"/>
</linearGradient>
<radialGradient id="paint3_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(435.034 72.8853) scale(14.2354)">
<stop offset="0.239741" stop-color="#8F8F8F"/>
<stop offset="0.5" stop-color="#090A0F"/>
<stop offset="0.998025" stop-color="#090A0F"/>
</radialGradient>
<radialGradient id="paint4_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(435.033 72.885) scale(8.54123)">
<stop offset="0.0920066" stop-color="#242C33"/>
<stop offset="0.288974" stop-color="#1A1719"/>
<stop offset="1" stop-color="#1A1719"/>
</radialGradient>
<radialGradient id="paint5_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(435.034 66.743) rotate(90) scale(5.07849 10.157)">
<stop stop-color="#65BBFF"/>
<stop offset="0.581465" stop-color="#E0DDE7"/>
<stop offset="1" stop-color="#968BAC"/>
</radialGradient>
<radialGradient id="paint6_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(434.749 77.7587) rotate(90) scale(4.32822 7.2137)">
<stop stop-color="#88888A"/>
<stop offset="0.558353" stop-color="#8B8B8B"/>
<stop offset="1" stop-color="#505050"/>
</radialGradient>
<linearGradient id="paint7_linear" x1="6.51986" y1="1761.63" x2="31.216" y2="1761.63" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.4"/>
<stop offset="1" stop-color="white" stop-opacity="0"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="863.48" y1="1756.63" x2="838.784" y2="1756.63" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.4"/>
<stop offset="1" stop-color="white" stop-opacity="0"/>
</linearGradient>
</defs>
<path opacity="0.27474" d="M867.219 741.948C871.622 741.948 875.191 745.517 875.191 749.92V861.525C875.191 865.928 871.622 869.497 867.219 869.497V741.948Z" fill="#AFAFAF"/>
<path d="M867.219 741.948H869.497C872.642 741.948 875.191 744.498 875.191 747.642V863.803C875.191 866.948 872.642 869.497 869.497 869.497H867.219V741.948Z" fill="#BBBCBF"/>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="867" y="741" width="9" height="129">
<path d="M867.219 741.948H869.497C872.642 741.948 875.191 744.498 875.191 747.642V863.803C875.191 866.948 872.642 869.497 869.497 869.497H867.219V741.948Z" fill="white"/>
</mask>
<g mask="url(#mask0)">
<g filter="url(#filter0_f)">
<rect x="873.482" y="731.699" width="1.70825" height="149.187" fill="#B8B7B7"/>
</g>
<g filter="url(#filter1_f)">
<ellipse cx="871.774" cy="741.663" rx="9.11064" ry="4.84003" fill="#050505"/>
</g>
<g filter="url(#filter2_f)">
<ellipse cx="871.774" cy="869.782" rx="9.11064" ry="4.84003" fill="#050505"/>
</g>
</g>
<path opacity="0.27474" d="M867.219 377.052C871.622 377.052 875.191 380.621 875.191 385.024V609.943C875.191 614.346 871.622 617.915 867.219 617.915V377.052Z" fill="#AFAFAF"/>
<path d="M867.219 377.052H869.497C872.642 377.052 875.191 379.602 875.191 382.746V612.221C875.191 615.366 872.642 617.915 869.497 617.915H867.219V377.052Z" fill="#BBBCBF"/>
<mask id="mask1" mask-type="alpha" maskUnits="userSpaceOnUse" x="867" y="377" width="9" height="241">
<path d="M867.219 377.052H869.497C872.642 377.052 875.191 379.602 875.191 382.746V612.221C875.191 615.366 872.642 617.915 869.497 617.915H867.219V377.052Z" fill="white"/>
</mask>
<g mask="url(#mask1)">
<g filter="url(#filter3_f)">
<rect x="874.052" y="357.593" width="2.84708" height="280.921" fill="#AFADAD"/>
</g>
<rect x="873.482" y="357.593" width="1.70825" height="280.921" fill="#878789"/>
<g filter="url(#filter4_f)">
<circle cx="871.774" cy="373.067" r="9.11064" fill="#050505"/>
</g>
<g filter="url(#filter5_f)">
<circle cx="871.774" cy="622.471" r="9.11064" fill="#050505"/>
</g>
</g>
<g filter="url(#filter6_i)">
<path d="M0 167.636C0 108.958 0 79.6188 11.4195 57.2067C21.4644 37.4925 37.4925 21.4644 57.2067 11.4195C79.6188 0 108.958 0 167.636 0H702.431C761.109 0 790.448 0 812.86 11.4195C832.574 21.4644 848.602 37.4925 858.647 57.2067C870.067 79.6188 870.067 108.958 870.067 167.636V1732.28C870.067 1790.63 870.067 1819.81 858.709 1842.1C848.719 1861.71 832.778 1877.65 813.171 1887.64C790.88 1899 761.701 1899 703.342 1899H166.725C108.366 1899 79.1861 1899 56.8958 1887.64C37.2888 1877.65 21.3477 1861.71 11.3574 1842.1C0 1819.81 0 1790.63 0 1732.28V167.636Z" fill="#6D6C72"/>
</g>
<g filter="url(#filter7_d)">
<path d="M6.26367 159.55C6.26367 107.888 6.26367 82.0567 16.3178 62.3243C25.1617 44.9673 39.2734 30.8555 56.6305 22.0117C76.3628 11.9575 102.194 11.9575 153.856 11.9575H716.211C767.873 11.9575 793.704 11.9575 813.436 22.0117C830.793 30.8555 844.905 44.9673 853.749 62.3243C863.803 82.0567 863.803 107.888 863.803 159.55V1732.62C863.803 1787.47 863.803 1814.89 853.128 1835.84C843.739 1854.27 828.756 1869.26 810.327 1878.64C789.377 1889.32 761.951 1889.32 707.1 1889.32H162.967C108.116 1889.32 80.6899 1889.32 59.7395 1878.64C41.311 1869.26 26.3282 1854.27 16.9384 1835.84C6.26367 1814.89 6.26367 1787.47 6.26367 1732.62V159.55Z" fill="url(#paint0_linear)"/>
<path d="M6.83309 159.55C6.83309 133.709 6.83353 114.363 8.08796 99.0098C9.34185 83.6629 11.8458 72.3553 16.8252 62.5828C25.6144 45.3329 39.6391 31.3083 56.889 22.519C66.6615 17.5397 77.9691 15.0357 93.316 13.7818C108.669 12.5274 128.016 12.5269 153.856 12.5269H716.211C742.051 12.5269 761.397 12.5274 776.751 13.7818C792.098 15.0357 803.405 17.5397 813.178 22.519C830.428 31.3083 844.452 45.3329 853.242 62.5828C858.221 72.3553 860.725 83.6629 861.979 99.0098C863.233 114.363 863.234 133.709 863.234 159.55V1732.62C863.234 1760.05 863.233 1780.59 861.901 1796.9C860.57 1813.19 857.911 1825.2 852.621 1835.59C843.286 1853.91 828.39 1868.8 810.069 1878.14C799.687 1883.43 787.676 1886.09 771.38 1887.42C755.077 1888.75 734.535 1888.75 707.1 1888.75H162.967C135.532 1888.75 114.99 1888.75 98.6867 1887.42C82.3903 1886.09 70.3796 1883.43 59.998 1878.14C41.6767 1868.8 26.781 1853.91 17.4458 1835.59C12.1561 1825.2 9.49701 1813.19 8.16554 1796.9C6.83353 1780.59 6.83309 1760.05 6.83309 1732.62V159.55Z" stroke="url(#paint1_angular)" stroke-width="1.13883"/>
<path d="M6.83309 159.55C6.83309 133.709 6.83353 114.363 8.08796 99.0098C9.34185 83.6629 11.8458 72.3553 16.8252 62.5828C25.6144 45.3329 39.6391 31.3083 56.889 22.519C66.6615 17.5397 77.9691 15.0357 93.316 13.7818C108.669 12.5274 128.016 12.5269 153.856 12.5269H716.211C742.051 12.5269 761.397 12.5274 776.751 13.7818C792.098 15.0357 803.405 17.5397 813.178 22.519C830.428 31.3083 844.452 45.3329 853.242 62.5828C858.221 72.3553 860.725 83.6629 861.979 99.0098C863.233 114.363 863.234 133.709 863.234 159.55V1732.62C863.234 1760.05 863.233 1780.59 861.901 1796.9C860.57 1813.19 857.911 1825.2 852.621 1835.59C843.286 1853.91 828.39 1868.8 810.069 1878.14C799.687 1883.43 787.676 1886.09 771.38 1887.42C755.077 1888.75 734.535 1888.75 707.1 1888.75H162.967C135.532 1888.75 114.99 1888.75 98.6867 1887.42C82.3903 1886.09 70.3796 1883.43 59.998 1878.14C41.6767 1868.8 26.781 1853.91 17.4458 1835.59C12.1561 1825.2 9.49701 1813.19 8.16554 1796.9C6.83353 1780.59 6.83309 1760.05 6.83309 1732.62V159.55Z" stroke="url(#paint2_linear)" stroke-width="1.13883"/>
</g>
<circle cx="435.033" cy="72.885" r="22.7766" fill="#212022"/>
<g filter="url(#filter8_di)">
<circle cx="435.034" cy="72.8853" r="14.2354" fill="url(#paint3_angular)"/>
</g>
<g filter="url(#filter9_di)">
<circle cx="435.033" cy="72.885" r="8.54123" fill="url(#paint4_angular)"/>
</g>
<mask id="mask2" mask-type="alpha" maskUnits="userSpaceOnUse" x="426" y="64" width="18" height="18">
<circle cx="435.033" cy="72.885" r="8.54123" fill="white"/>
</mask>
<g mask="url(#mask2)">
<g filter="url(#filter10_f)">
<circle cx="435.034" cy="73.4544" r="9.11064" fill="#1A1719"/>
</g>
<g opacity="0.776204" filter="url(#filter11_f)">
<ellipse cx="435.034" cy="66.6216" rx="6.83298" ry="3.41649" fill="url(#paint5_radial)"/>
</g>
<g filter="url(#filter12_f)">
<ellipse cx="434.749" cy="81.7113" rx="4.27061" ry="2.56237" fill="url(#paint6_radial)"/>
</g>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M158.867 1889.32V1899H171.394V1889.32H158.867Z" fill="#F0F2F5" fill-opacity="0.15"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M698.672 1889.32V1899H711.2V1889.32H698.672Z" fill="#F0F2F5" fill-opacity="0.15"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M304.067 0V10.2495H316.595V0H304.067Z" fill="#F0F2F5" fill-opacity="0.15"/>
<mask id="mask3" mask-type="alpha" maskUnits="userSpaceOnUse" x="7" y="12" width="857" height="1878">
<path d="M7.40234 160.12C7.40234 108.458 7.40234 82.6265 17.4565 62.8941C26.3003 45.5371 40.4121 31.4253 57.7691 22.5815C77.5015 12.5273 103.333 12.5273 154.995 12.5273H716.21C767.873 12.5273 793.704 12.5273 813.436 22.5815C830.793 31.4253 844.905 45.5371 853.749 62.8941C863.803 82.6265 863.803 108.458 863.803 160.12V1732.62C863.803 1787.47 863.803 1814.89 853.128 1835.84C843.738 1854.27 828.756 1869.26 810.327 1878.65C789.377 1889.32 761.951 1889.32 707.1 1889.32H164.105C109.254 1889.32 81.8286 1889.32 60.8782 1878.65C42.4497 1869.26 27.4669 1854.27 18.0771 1835.84C7.40234 1814.89 7.40234 1787.47 7.40234 1732.62V160.12Z" fill="white"/>
</mask>
<g mask="url(#mask3)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M63.7443 29C63.7443 29 55.2299 36.8616 53.0867 39.7588C40.8259 56.3323 34.6011 70.2186 29.3148 84.1024C29.3148 84.1024 25.511 107.109 25.4776 145.858L25.4771 1754.46C25.4771 1797.42 27.3063 1812.99 30.7411 1828.7C34.1759 1844.4 39.2164 1856.73 45.639 1865.13C51.9973 1873.44 58.3047 1877.91 75.4763 1878L76 1878H56.5235C38.9556 1878 32.5851 1873.53 26.1625 1865.13C19.7399 1856.73 14.6995 1844.4 11.2646 1828.7C7.8298 1812.99 6.00061 1797.42 6.00061 1754.46V147.064C6.00061 106.603 6.57138 91.2549 12.2086 77.1396C17.8458 63.0243 24.1796 53.9429 34.7005 45.4981C39.8847 41.337 44.651 37.2472 52.7494 33.2286C55.6078 31.8102 63.7443 29 63.7443 29Z" fill="url(#paint7_linear)"/>
</g>
<mask id="mask4" mask-type="alpha" maskUnits="userSpaceOnUse" x="7" y="13" width="856" height="1876">
<path d="M862.664 160.689C862.664 109.027 862.664 83.1958 852.61 63.4635C843.766 46.1064 829.654 31.9947 812.297 23.1508C792.565 13.0967 766.734 13.0967 715.072 13.0967H154.995C103.333 13.0967 77.5014 13.0967 57.7691 23.1508C40.412 31.9947 26.3003 46.1064 17.4564 63.4635C7.40228 83.1958 7.40228 109.027 7.40228 160.689V1731.48C7.40228 1786.33 7.40228 1813.76 18.077 1834.71C27.4668 1853.13 42.4496 1868.12 60.8781 1877.51C81.8286 1888.18 109.254 1888.18 164.105 1888.18H705.961C760.812 1888.18 788.238 1888.18 809.188 1877.51C827.617 1868.12 842.6 1853.13 851.989 1834.71C862.664 1813.76 862.664 1786.33 862.664 1731.48V160.689Z" fill="white"/>
</mask>
<g mask="url(#mask4)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M806.256 24C806.256 24 814.77 31.8616 816.913 34.7588C829.174 51.3323 835.399 65.2186 840.685 79.1024C840.685 79.1024 844.489 102.109 844.522 140.858L844.523 1749.46C844.523 1792.42 842.694 1807.99 839.259 1823.7C835.824 1839.4 830.784 1851.73 824.361 1860.13C818.003 1868.44 811.695 1872.91 794.524 1873L794 1873H813.476C831.044 1873 837.415 1868.53 843.838 1860.13C850.26 1851.73 855.301 1839.4 858.735 1823.7C862.17 1807.99 863.999 1792.42 863.999 1749.46V142.064C863.999 101.603 863.429 86.2549 857.791 72.1396C852.154 58.0243 845.82 48.9429 835.299 40.4981C830.115 36.337 825.349 32.2472 817.251 28.2286C814.392 26.8102 806.256 24 806.256 24Z" fill="url(#paint8_linear)"/>
</g>



</svg>
''',
    frameSize: Size(876.0, 1899.0),
    screenSize: Size(360.0, 800.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.android,
      DeviceType.phone,
      'large',
    ),
    name: 'Large Phone',
    pixelRatio: 3.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          45.0234,
          137.028,
          800.0,
          1280.0,
        ),
      ),
    svgFrame:
        '''<svg width="892" height="1526" viewBox="0 0 892 1526" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_i" x="0" y="0" width="886.042" height="1525.06" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.746455"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter1_iiii" x="8.21082" y="8.97803" width="871.86" height="1508.11" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.746455"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0.35 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.11968"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.746455"/>
<feGaussianBlur stdDeviation="0.373228"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.746455"/>
<feGaussianBlur stdDeviation="1.11968"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter2_f" x="14.1438" y="29.2146" width="62.8773" height="1466.73" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.01454" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter3_f" x="801.954" y="25.7248" width="72.3209" height="1462.91" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.01454" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter4_iii" x="885.502" y="217" width="9.49777" height="88.4792" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.999765" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset dx="1.49965"/>
<feGaussianBlur stdDeviation="0.249941"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.24 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.999765" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dx="3.99906"/>
<feGaussianBlur stdDeviation="0.999765"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.24 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-0.999765"/>
<feGaussianBlur stdDeviation="0.249941"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.12 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter5_ii" x="885.5" y="335.28" width="7.49824" height="176.459" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="2.99929"/>
<feGaussianBlur stdDeviation="0.499882"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.49965"/>
<feGaussianBlur stdDeviation="0.249941"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter6_diii" x="367.547" y="71.1487" width="149.245" height="18.8576" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.538789"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.07758" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="-0.538789"/>
<feGaussianBlur stdDeviation="0.808183"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.538789" operator="erode" in="SourceAlpha" result="effect3_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.538789"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.538789"/>
<feGaussianBlur stdDeviation="0.808183"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter7_diii" x="382" y="1458.48" width="121.356" height="19.2585" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.520253"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.520253" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="1.04051"/>
<feGaussianBlur stdDeviation="0.78038"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.520253" operator="erode" in="SourceAlpha" result="effect3_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.520253"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.520253"/>
<feGaussianBlur stdDeviation="0.78038"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter8_f" x="328.031" y="78.3771" width="16.3003" height="15.7384" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.78458" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter9_f" x="333.596" y="84.0144" width="5.76466" height="5.62174" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.446146" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter10_f" x="324.716" y="72.7498" width="7.71016" height="6.60849" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.446146" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter11_d" x="322.672" y="71.6717" width="19.3671" height="19.3671" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.164128"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter12_f" x="327.124" y="74.8106" width="6.65798" height="6.57183" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.892291" result="effect1_foregroundBlur"/>
</filter>
<radialGradient id="paint0_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(463.147 762.529) rotate(90) scale(878.152 510.197)">
<stop stop-color="#1E1E1E"/>
<stop offset="1" stop-color="#0A0A0A"/>
</radialGradient>
<linearGradient id="paint1_linear" x1="18.3285" y1="1128.81" x2="89.7173" y2="1128.81" gradientUnits="userSpaceOnUse">
<stop stop-color="#EEEEEE" stop-opacity="0.855101"/>
<stop offset="1" stop-color="#D8D8D8" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="16.1729" y1="31.2437" x2="16.1729" y2="1493.92" gradientUnits="userSpaceOnUse">
<stop stop-color="#686868"/>
<stop offset="0.019851" stop-color="#C6C6C6"/>
<stop offset="0.0526644" stop-color="#E4E4E4"/>
<stop offset="0.787327" stop-color="#D0D0D0"/>
<stop offset="0.939455" stop-color="#C5C5C5"/>
<stop offset="0.954674" stop-color="white"/>
<stop offset="0.98365" stop-color="#ADADAD"/>
<stop offset="1" stop-color="#D8D8D8"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="808.154" y1="931.182" x2="877.094" y2="931.182" gradientUnits="userSpaceOnUse">
<stop stop-color="#EEEEEE" stop-opacity="0.01"/>
<stop offset="0.794113" stop-color="#E0E0E0" stop-opacity="0.525957"/>
<stop offset="0.833895" stop-color="#E1E1E1" stop-opacity="0.508693"/>
<stop offset="1" stop-color="#D8D8D8"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="816.111" y1="27.7539" x2="816.111" y2="1486.6" gradientUnits="userSpaceOnUse">
<stop stop-color="#8C8A8D"/>
<stop offset="0.0244456" stop-color="#747474"/>
<stop offset="0.0611492" stop-color="#949494"/>
<stop offset="0.0915986" stop-color="#BFBFBF"/>
<stop offset="0.14244" stop-color="#ADADAD"/>
<stop offset="0.348646" stop-color="#8B8B8B"/>
<stop offset="0.402614" stop-color="#595F58"/>
<stop offset="0.55256" stop-color="#6D6F6F"/>
<stop offset="0.736922" stop-color="#606660"/>
<stop offset="0.88443" stop-color="#EAEAEA"/>
<stop offset="0.944479" stop-color="#B5B5B5"/>
<stop offset="0.988288" stop-color="#6B6B6B"/>
<stop offset="1" stop-color="#4F4D4D"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="886.002" y1="217" x2="886.002" y2="305.479" gradientUnits="userSpaceOnUse">
<stop stop-color="#373737"/>
<stop offset="0.0307924" stop-color="#4C4C4C"/>
<stop offset="0.0685746" stop-color="#363636"/>
<stop offset="0.916235" stop-color="#3D3D3D"/>
<stop offset="0.971221" stop-color="#202020"/>
<stop offset="1" stop-color="#767676"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="886" y1="335.28" x2="886" y2="511.738" gradientUnits="userSpaceOnUse">
<stop stop-color="#505050"/>
<stop offset="0.0134163" stop-color="#B3B3B3"/>
<stop offset="0.0412327" stop-color="#212121"/>
<stop offset="0.110692" stop-color="#242424"/>
<stop offset="0.876962" stop-color="#191919"/>
<stop offset="0.957457" stop-color="#2A2A2A"/>
<stop offset="1" stop-color="#212121"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="149.245" y1="17.78" x2="149.245" y2="0" gradientUnits="userSpaceOnUse">
<stop stop-color="#313131"/>
<stop offset="0.521857" stop-color="#2E2E2E"/>
<stop offset="1" stop-color="#282727"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="503.356" y1="1476.7" x2="503.356" y2="1459" gradientUnits="userSpaceOnUse">
<stop stop-color="#313131"/>
<stop offset="0.521857" stop-color="#2E2E2E"/>
<stop offset="1" stop-color="#282727"/>
</linearGradient>
<radialGradient id="paint9_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(336.148 86.197) scale(4.61412 4.34939)">
<stop stop-color="#394B90"/>
<stop offset="0.154352" stop-color="#414A7C"/>
<stop offset="0.377408" stop-color="#293A81"/>
<stop offset="0.646932" stop-color="#37498E"/>
<stop offset="0.900234" stop-color="#24357E"/>
<stop offset="1" stop-color="#485491"/>
</radialGradient>
<radialGradient id="paint10_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(336.479 86.8253) rotate(90) scale(3.27476 3.39673)">
<stop stop-color="#EEEEEE"/>
<stop offset="0.268157" stop-color="#E8E8E8" stop-opacity="0.573454"/>
<stop offset="1" stop-color="#D8D8D8" stop-opacity="0.122877"/>
</radialGradient>
<radialGradient id="paint11_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(332.355 81.3553) scale(9.35529)">
<stop offset="0.147774" stop-color="#231E1B"/>
<stop offset="0.379161" stop-color="#5F5F5F" stop-opacity="0.210456"/>
<stop offset="0.62265" stop-opacity="0.280797"/>
<stop offset="0.882483" stop-opacity="0.374321"/>
</radialGradient>
</defs>
<g filter="url(#filter0_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M773.099 0H114.976C64.9113 0 0 32.0294 0 115.803V1412.5C0 1450.5 21.4941 1525.06 108.318 1525.06H386.163C387.113 1524.21 392.077 1520 397.397 1520H483.02C487.703 1520 492.447 1524.21 493.358 1525.06H773.099C860.693 1525.06 886.042 1453.89 886.042 1417.16V112.433C886.042 65.5772 858.349 0 773.099 0Z" fill="url(#paint0_radial)"/>
</g>
<g filter="url(#filter1_iiii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M114.872 8.97803C145.041 8.97803 369.355 8.97803 770.91 8.97803C855.697 8.97803 880.07 72.1671 880.07 118.635C880.07 148.561 880.071 342.664 880.071 1415.41C880.071 1451.83 857.102 1516.35 770.91 1516.35C752.857 1516.35 523.47 1516.35 114.872 1516.35C29.4381 1516.35 8.21082 1448.18 8.21082 1410.5C8.21082 363.152 8.21082 172.081 8.21082 118.635C8.21082 35.5551 65.6089 8.97803 114.872 8.97803Z" fill="black"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="0" y="31" width="143" height="1463">
<rect y="31.125" width="142.573" height="1462.88" fill="url(#paint1_linear)"/>
</mask>
<g mask="url(#mask0)">
<g filter="url(#filter2_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M66.6956 1493.92C66.6956 1493.92 60.5284 1489.3 53.2766 1485.5C39.7262 1478.41 36.2112 1470.29 33.2279 1466.93C26.3581 1459.18 21.3341 1448.05 20.463 1436.29C19.5919 1424.53 20.463 122.765 20.463 122.765C20.463 122.765 20.463 91.8878 22.1053 83.8718C23.7475 75.8559 24.8286 72.3733 30.959 62.5606C37.0894 52.7478 43.3017 47.5018 49.0029 43.509C55.8363 38.7232 74.992 31.2437 74.992 31.2437C74.992 31.2437 55.5523 36.7163 46.59 42.2541C39.419 46.6849 28.5414 57.6698 22.1053 71.5343C18.4049 79.5056 16.6786 90.0014 16.6786 98.1559C16.6786 120.494 15.5407 1421.86 16.6786 1434.17C17.8164 1446.48 20.9617 1454.6 27.1654 1462.49C30.5261 1466.76 34.0868 1474.96 43.8095 1481.65C52.0344 1487.31 66.6956 1493.92 66.6956 1493.92Z" fill="url(#paint2_linear)"/>
</g>
</g>
<mask id="mask1" mask-type="alpha" maskUnits="userSpaceOnUse" x="766" y="27" width="109" height="1487">
<path d="M766.059 27.7539H874.774V1514H766.059V27.7539Z" fill="url(#paint3_linear)"/>
</mask>
<g mask="url(#mask1)">
<g filter="url(#filter3_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M803.983 27.7539C803.983 27.7539 820.05 33.4546 826.226 36.5049C836.808 41.7305 843.769 47.3914 846.114 49.4287C851.685 54.2685 859.211 62.8596 863.504 73.1363C867.15 81.8667 867.395 92.0731 867.395 103.194C867.395 127.407 867.395 1409.19 867.395 1409.19C867.395 1409.19 869.011 1438.34 860.459 1453.17C855.874 1461.11 856.574 1463.25 849.097 1470.45C840.992 1478.25 832.221 1486.6 832.221 1486.6C832.221 1486.6 852.986 1472.11 856.018 1468.25C858.381 1465.25 864.374 1455.65 867.921 1447.86C872.332 1438.18 872.246 1425.47 872.246 1419.96C872.246 1410.01 871.111 98.3492 871.111 87.8217C871.111 77.2942 861.848 60.119 853.59 52.2279C845.333 44.3368 835.303 36.6448 826.226 32.9644C817.15 29.2839 803.983 27.7539 803.983 27.7539Z" fill="url(#paint4_linear)"/>
</g>
</g>
<g filter="url(#filter4_iii)">
<path d="M886.002 217H889.001C890.657 217 892 218.343 892 219.999V302.48C892 304.136 890.657 305.479 889.001 305.479H886.002V217Z" fill="url(#paint5_linear)"/>
</g>
<g filter="url(#filter5_ii)">
<path d="M886 335.28H888.999C890.656 335.28 891.999 336.623 891.999 338.279V508.739C891.999 510.395 890.656 511.738 888.999 511.738H886V335.28Z" fill="url(#paint6_linear)"/>
</g>
<g filter="url(#filter6_diii)">
<rect width="149.245" height="17.78" rx="8.89002" transform="matrix(1 0 0 -1 367.547 89.4678)" fill="url(#paint7_linear)"/>
</g>
<g filter="url(#filter7_diii)">
<rect x="382" y="1459" width="121.356" height="17.6977" rx="8.58418" fill="url(#paint8_linear)"/>
</g>
<g filter="url(#filter8_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M331.716 90.5464C331.716 90.5464 330.98 84.5127 333.221 82.736C335.462 80.9593 340.763 82.736 340.763 82.736C340.763 82.736 338.485 86.1289 336.751 87.7043C335.018 89.2797 331.716 90.5464 331.716 90.5464Z" fill="url(#paint9_angular)"/>
</g>
<g filter="url(#filter9_f)">
<ellipse cx="336.479" cy="86.8253" rx="1.99004" ry="1.91858" fill="url(#paint10_radial)" fill-opacity="0.2"/>
</g>
<g filter="url(#filter10_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M331.534 73.6419C331.534 73.6419 329.222 74.7763 328.018 75.7756C326.815 76.7749 325.609 78.4658 325.609 78.4658C325.609 78.4658 326.05 76.3023 327.14 75.2966C328.23 74.2908 331.534 73.6419 331.534 73.6419Z" fill="#D8D8D8" fill-opacity="0.5"/>
</g>
<g filter="url(#filter11_d)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M332.355 90.7106C337.522 90.7106 341.711 86.5221 341.711 81.3553C341.711 76.1885 337.522 72 332.355 72C327.189 72 323 76.1885 323 81.3553C323 86.5221 327.189 90.7106 332.355 90.7106ZM332.355 89.0696C336.616 89.0696 340.069 85.616 340.069 81.3556C340.069 77.0953 336.616 73.6416 332.355 73.6416C328.095 73.6416 324.641 77.0953 324.641 81.3556C324.641 85.616 328.095 89.0696 332.355 89.0696Z" fill="url(#paint11_angular)"/>
</g>
<g filter="url(#filter12_f)">
<ellipse cx="330.453" cy="78.0965" rx="1.54441" ry="1.50134" fill="white"/>
</g>



</svg>
''',
    frameSize: Size(892.0, 1526.0),
    screenSize: Size(800.0, 1280.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.android,
      DeviceType.tablet,
      'android-10-inch',
    ),
    name: 'Android Tablet 10"',
    pixelRatio: 3.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          0.0,
          0.0,
          720.0,
          1280.0,
        ),
      ),
    svgFrame:
        '''<svg width="720" height="1280" viewBox="0 0 720 1280" fill="none" xmlns="http://www.w3.org/2000/svg">
	<!-- SCREEN SHAPE -->
	
	<!-- DEVICE PROPERTIES -->
	
</svg>
''',
    frameSize: Size(720.0, 1280.0),
    screenSize: Size(720.0, 1280.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.android,
      DeviceType.phone,
      'pixel3',
    ),
    name: 'Pixel 3',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          39.6331,
          143.399,
          778.249,
          1556.5,
        ),
      ),
    svgFrame:
        '''<svg width="864" height="1833" viewBox="0 0 864 1833" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_i" x="0" y="0" width="855.353" height="1832" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.7206"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter1_iiii" x="7.92651" y="8.66895" width="841.661" height="1817.55" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.7206"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0.35 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.0809"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0 0.921569 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.7206"/>
<feGaussianBlur stdDeviation="0.3603"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.7206"/>
<feGaussianBlur stdDeviation="1.0809"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter2_f" x="13.654" y="23.4069" width="60.6995" height="1785.72" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.979398" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter3_f" x="773.595" y="20.611" width="70.1089" height="1785.11" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.979398" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter4_iii" x="854.632" y="397.771" width="13.6914" height="127.546" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.4412" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset dx="2.1618"/>
<feGaussianBlur stdDeviation="0.3603"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.24 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.4412" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dx="5.7648"/>
<feGaussianBlur stdDeviation="1.4412"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.24 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.4412"/>
<feGaussianBlur stdDeviation="0.3603"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.12 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter5_ii" x="854.632" y="646.379" width="10.809" height="254.372" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="4.3236"/>
<feGaussianBlur stdDeviation="0.7206"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-2.1618"/>
<feGaussianBlur stdDeviation="0.3603"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter6_diii" x="330.035" y="53.3243" width="199.606" height="25.221" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.7206"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.4412" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="-0.7206"/>
<feGaussianBlur stdDeviation="1.0809"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.7206" operator="erode" in="SourceAlpha" result="effect3_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.7206"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.7206"/>
<feGaussianBlur stdDeviation="1.0809"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter7_diii" x="330.035" y="1753.22" width="199.606" height="25.9416" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.7206"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.7206" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="1.4412"/>
<feGaussianBlur stdDeviation="1.0809"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.7206" operator="erode" in="SourceAlpha" result="effect3_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.7206"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.7206"/>
<feGaussianBlur stdDeviation="1.0809"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter8_f" x="256.771" y="86.0598" width="35.783" height="34.5496" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="3.91759" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter9_f" x="268.987" y="98.4352" width="12.6548" height="12.3411" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.979398" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter10_f" x="249.494" y="73.7043" width="16.9257" height="14.5072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.979398" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter11_d" x="245.004" y="71.3395" width="42.5154" height="42.5154" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.3603"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter12_f" x="254.778" y="78.2308" width="14.6159" height="14.4268" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.9588" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter13_f" x="154.965" y="88.4249" width="23.0846" height="22.284" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="2.50726" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter14_f" x="162.841" y="96.4046" width="8.1788" height="7.97514" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.626814" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter15_f" x="150.187" y="80.3514" width="10.9511" height="9.38124" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.626814" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter16_d" x="147.003" y="78.5455" width="28.1034" height="28.1034" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.3603"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter17_f" x="153.636" y="83.3077" width="9.41603" height="9.29327" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.25363" result="effect1_foregroundBlur"/>
</filter>
<radialGradient id="paint0_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(447.106 916.001) rotate(90) scale(1054.9 492.525)">
<stop stop-color="#1E1E1E"/>
<stop offset="1" stop-color="#0A0A0A"/>
</radialGradient>
<linearGradient id="paint1_linear" x1="17.6937" y1="1362.39" x2="86.6098" y2="1362.39" gradientUnits="userSpaceOnUse">
<stop stop-color="#EEEEEE" stop-opacity="0.855101"/>
<stop offset="1" stop-color="#D8D8D8" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="15.6128" y1="25.3657" x2="15.6128" y2="1807.17" gradientUnits="userSpaceOnUse">
<stop stop-color="#686868"/>
<stop offset="0.019851" stop-color="#C6C6C6"/>
<stop offset="0.0526644" stop-color="#E4E4E4"/>
<stop offset="0.787327" stop-color="#D0D0D0"/>
<stop offset="0.939455" stop-color="#C5C5C5"/>
<stop offset="0.954674" stop-color="white"/>
<stop offset="0.98365" stop-color="#ADADAD"/>
<stop offset="1" stop-color="#D8D8D8"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="779.352" y1="1121.02" x2="846.069" y2="1121.02" gradientUnits="userSpaceOnUse">
<stop stop-color="#EEEEEE" stop-opacity="0.01"/>
<stop offset="0.794113" stop-color="#E0E0E0" stop-opacity="0.525957"/>
<stop offset="0.833895" stop-color="#E1E1E1" stop-opacity="0.508693"/>
<stop offset="1" stop-color="#D8D8D8"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="787.313" y1="22.5698" x2="787.313" y2="1803.76" gradientUnits="userSpaceOnUse">
<stop stop-color="#8C8A8D"/>
<stop offset="0.0244456" stop-color="#747474"/>
<stop offset="0.0611492" stop-color="#949494"/>
<stop offset="0.0915986" stop-color="#BFBFBF"/>
<stop offset="0.14244" stop-color="#ADADAD"/>
<stop offset="0.348646" stop-color="#8B8B8B"/>
<stop offset="0.402614" stop-color="#595F58"/>
<stop offset="0.55256" stop-color="#6D6F6F"/>
<stop offset="0.736922" stop-color="#606660"/>
<stop offset="0.88443" stop-color="#EAEAEA"/>
<stop offset="0.944479" stop-color="#B5B5B5"/>
<stop offset="0.988288" stop-color="#6B6B6B"/>
<stop offset="1" stop-color="#4F4D4D"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="855.353" y1="397.771" x2="855.353" y2="525.318" gradientUnits="userSpaceOnUse">
<stop stop-color="#373737"/>
<stop offset="0.0307924" stop-color="#4C4C4C"/>
<stop offset="0.0685746" stop-color="#363636"/>
<stop offset="0.916235" stop-color="#3D3D3D"/>
<stop offset="0.971221" stop-color="#202020"/>
<stop offset="1" stop-color="#767676"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="855.353" y1="646.379" x2="855.353" y2="900.751" gradientUnits="userSpaceOnUse">
<stop stop-color="#505050"/>
<stop offset="0.0134163" stop-color="#B3B3B3"/>
<stop offset="0.0412327" stop-color="#212121"/>
<stop offset="0.110692" stop-color="#242424"/>
<stop offset="0.876962" stop-color="#191919"/>
<stop offset="0.957457" stop-color="#2A2A2A"/>
<stop offset="1" stop-color="#212121"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="529.642" y1="77.8247" x2="529.642" y2="54.0449" gradientUnits="userSpaceOnUse">
<stop stop-color="#313131"/>
<stop offset="0.521857" stop-color="#2E2E2E"/>
<stop offset="1" stop-color="#282727"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="529.641" y1="1777.72" x2="529.641" y2="1753.94" gradientUnits="userSpaceOnUse">
<stop stop-color="#313131"/>
<stop offset="0.521857" stop-color="#2E2E2E"/>
<stop offset="1" stop-color="#282727"/>
</linearGradient>
<radialGradient id="paint9_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(274.59 103.226) scale(10.1291 9.54796)">
<stop stop-color="#394B90"/>
<stop offset="0.154352" stop-color="#414A7C"/>
<stop offset="0.377408" stop-color="#293A81"/>
<stop offset="0.646932" stop-color="#37498E"/>
<stop offset="0.900234" stop-color="#24357E"/>
<stop offset="1" stop-color="#485491"/>
</radialGradient>
<radialGradient id="paint10_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(275.314 104.606) rotate(90) scale(7.18889 7.45664)">
<stop stop-color="#EEEEEE"/>
<stop offset="0.268157" stop-color="#E8E8E8" stop-opacity="0.573454"/>
<stop offset="1" stop-color="#D8D8D8" stop-opacity="0.122877"/>
</radialGradient>
<radialGradient id="paint11_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(266.262 92.5972) scale(20.5371)">
<stop offset="0.147774" stop-color="#231E1B"/>
<stop offset="0.379161" stop-color="#5F5F5F" stop-opacity="0.210456"/>
<stop offset="0.62265" stop-opacity="0.280797"/>
<stop offset="0.882483" stop-opacity="0.374321"/>
</radialGradient>
<radialGradient id="paint12_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(166.46 99.4966) scale(6.57503 6.1978)">
<stop stop-color="#394B90"/>
<stop offset="0.154352" stop-color="#414A7C"/>
<stop offset="0.377408" stop-color="#293A81"/>
<stop offset="0.646932" stop-color="#37498E"/>
<stop offset="0.900234" stop-color="#24357E"/>
<stop offset="1" stop-color="#485491"/>
</radialGradient>
<radialGradient id="paint13_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(166.93 100.392) rotate(90) scale(4.66647 4.84028)">
<stop stop-color="#EEEEEE"/>
<stop offset="0.268157" stop-color="#E8E8E8" stop-opacity="0.573454"/>
<stop offset="1" stop-color="#D8D8D8" stop-opacity="0.122877"/>
</radialGradient>
<radialGradient id="paint14_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(161.054 92.5972) scale(13.3311)">
<stop offset="0.147774" stop-color="#231E1B"/>
<stop offset="0.379161" stop-color="#5F5F5F" stop-opacity="0.210456"/>
<stop offset="0.62265" stop-opacity="0.280797"/>
<stop offset="0.882483" stop-opacity="0.374321"/>
</radialGradient>
</defs>
<g filter="url(#filter0_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M746.321 0H110.994C62.663 0 0 30.92 0 111.792V1723.34C0 1760.03 20.7496 1832 104.566 1832H381.214C383.101 1830.98 385.42 1830.1 387.813 1830.1H470.47C472.577 1830.1 474.697 1830.98 476.449 1832H746.321C830.882 1832 855.353 1763.31 855.353 1727.85V108.538C855.353 63.3058 828.618 0 746.321 0Z" fill="url(#paint0_radial)"/>
</g>
<g filter="url(#filter1_iiii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M110.894 8.66895C140.017 8.66895 356.562 8.66895 744.208 8.66895C826.059 8.66895 849.588 69.6694 849.588 114.527C849.588 143.417 849.588 692.472 849.588 1728.06C849.588 1763.22 827.415 1825.5 744.208 1825.5C726.781 1825.5 505.339 1825.5 110.894 1825.5C28.4185 1825.5 7.92651 1759.7 7.92651 1723.32C7.92651 712.25 7.92651 166.123 7.92651 114.527C7.92651 34.3255 63.3366 8.66895 110.894 8.66895Z" fill="black"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="0" y="25" width="138" height="1783">
<rect y="25.2212" width="137.635" height="1782.05" fill="url(#paint1_linear)"/>
</mask>
<g mask="url(#mask0)">
<g filter="url(#filter2_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M64.3856 1807.17C64.3856 1807.17 58.432 1801.54 51.4314 1796.91C38.3503 1788.27 34.957 1778.39 32.0771 1774.29C25.4453 1764.85 20.5953 1751.29 19.7544 1736.96C18.9135 1722.64 19.7544 136.855 19.7544 136.855C19.7544 136.855 19.7544 99.2412 21.3397 89.4763C22.9251 79.7114 23.9687 75.4691 29.8868 63.5154C35.8048 51.5617 41.802 45.1711 47.3057 40.3071C53.9025 34.4772 72.3947 25.3657 72.3947 25.3657C72.3947 25.3657 53.6282 32.0324 44.9764 38.7784C38.0538 44.176 27.5529 57.5575 21.3397 74.447C17.7675 84.1575 16.101 96.9432 16.101 106.877C16.101 134.088 15.0026 1719.39 16.101 1734.38C17.1994 1749.37 20.2357 1759.27 26.2246 1768.88C29.4689 1774.09 32.9063 1784.08 42.2922 1792.23C50.2322 1799.12 64.3856 1807.17 64.3856 1807.17Z" fill="url(#paint2_linear)"/>
</g>
</g>
<mask id="mask1" mask-type="alpha" maskUnits="userSpaceOnUse" x="738" y="23" width="106" height="1809">
<rect x="738.615" y="23.0596" width="105.208" height="1808.71" fill="url(#paint3_linear)"/>
</mask>
<g mask="url(#mask1)">
<g filter="url(#filter3_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M775.553 22.5698C775.553 22.5698 791.132 29.5301 797.122 33.2544C807.382 39.6346 814.132 46.5464 816.406 49.0338C821.808 54.943 829.106 65.4324 833.268 77.9799C836.803 88.6393 837.041 101.101 837.041 114.679C837.041 144.242 837.041 1709.24 837.041 1709.24C837.041 1709.24 838.608 1744.84 830.315 1762.94C825.869 1772.64 826.548 1775.26 819.298 1784.04C811.439 1793.57 802.934 1803.76 802.934 1803.76C802.934 1803.76 823.069 1786.06 826.009 1781.36C828.3 1777.69 834.111 1765.97 837.551 1756.46C841.828 1744.64 841.745 1729.13 841.745 1722.39C841.745 1710.24 840.644 108.764 840.644 95.9101C840.644 83.0565 831.662 62.0863 823.655 52.4516C815.648 42.8168 805.923 33.4253 797.122 28.9316C788.321 24.4379 775.553 22.5698 775.553 22.5698Z" fill="url(#paint4_linear)"/>
</g>
</g>
<g filter="url(#filter4_iii)">
<path d="M855.353 397.771H859.677C862.064 397.771 864 399.707 864 402.095V520.994C864 523.382 862.064 525.318 859.677 525.318H855.353V397.771Z" fill="url(#paint5_linear)"/>
</g>
<g filter="url(#filter5_ii)">
<path d="M855.353 646.379H859.676C862.064 646.379 864 648.315 864 650.703V896.427C864 898.815 862.064 900.751 859.676 900.751H855.353V646.379Z" fill="url(#paint6_linear)"/>
</g>
<g filter="url(#filter6_diii)">
<rect x="330.035" y="54.0449" width="199.606" height="23.7798" rx="11.8899" fill="url(#paint7_linear)"/>
</g>
<g filter="url(#filter7_diii)">
<rect x="330.035" y="1753.94" width="199.606" height="23.7798" rx="11.8899" fill="url(#paint8_linear)"/>
</g>
<g filter="url(#filter8_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M264.86 112.774C264.86 112.774 263.244 99.5287 268.163 95.6284C273.083 91.7281 284.719 95.6284 284.719 95.6284C284.719 95.6284 279.719 103.077 275.913 106.535C272.107 109.993 264.86 112.774 264.86 112.774Z" fill="url(#paint9_angular)"/>
</g>
<g filter="url(#filter9_f)">
<ellipse cx="275.314" cy="104.606" rx="4.36862" ry="4.21175" fill="url(#paint10_radial)" fill-opacity="0.2"/>
</g>
<g filter="url(#filter10_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M264.46 75.6633C264.46 75.6633 259.384 78.1535 256.742 80.3472C254.1 82.5409 251.452 86.2529 251.452 86.2529C251.452 86.2529 252.421 81.5036 254.814 79.2956C257.207 77.0877 264.46 75.6633 264.46 75.6633Z" fill="#D8D8D8" fill-opacity="0.5"/>
</g>
<g filter="url(#filter11_d)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M266.262 113.134C277.604 113.134 286.799 103.94 286.799 92.5972C286.799 81.2548 277.604 72.0601 266.262 72.0601C254.92 72.0601 245.725 81.2548 245.725 92.5972C245.725 103.94 254.92 113.134 266.262 113.134ZM266.262 109.531C275.614 109.531 283.196 101.95 283.196 92.5973C283.196 83.2449 275.614 75.6632 266.262 75.6632C256.909 75.6632 249.328 83.2449 249.328 92.5973C249.328 101.95 256.909 109.531 266.262 109.531Z" fill="url(#paint11_angular)"/>
</g>
<g filter="url(#filter12_f)">
<ellipse cx="262.086" cy="85.4442" rx="3.39035" ry="3.29579" fill="white"/>
</g>
<g filter="url(#filter13_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M160.144 105.694C160.144 105.694 159.095 97.0965 162.288 94.5647C165.482 92.0329 173.035 94.5647 173.035 94.5647C173.035 94.5647 169.789 99.3995 167.319 101.644C164.849 103.889 160.144 105.694 160.144 105.694Z" fill="url(#paint12_angular)"/>
</g>
<g filter="url(#filter14_f)">
<ellipse cx="166.93" cy="100.392" rx="2.83577" ry="2.73394" fill="url(#paint13_radial)" fill-opacity="0.2"/>
</g>
<g filter="url(#filter15_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M159.885 81.605C159.885 81.605 156.59 83.2215 154.874 84.6455C153.159 86.0694 151.441 88.479 151.441 88.479C151.441 88.479 152.07 85.3961 153.623 83.9629C155.176 82.5296 159.885 81.605 159.885 81.605Z" fill="#D8D8D8" fill-opacity="0.5"/>
</g>
<g filter="url(#filter16_d)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M161.054 105.928C168.417 105.928 174.385 99.9598 174.385 92.5972C174.385 85.2347 168.417 79.2661 161.054 79.2661C153.692 79.2661 147.723 85.2347 147.723 92.5972C147.723 99.9598 153.692 105.928 161.054 105.928ZM161.054 103.59C167.125 103.59 172.047 98.6682 172.047 92.5973C172.047 86.5264 167.125 81.605 161.054 81.605C154.983 81.605 150.062 86.5264 150.062 92.5973C150.062 98.6682 154.983 103.59 161.054 103.59Z" fill="url(#paint14_angular)"/>
</g>
<g filter="url(#filter17_f)">
<ellipse cx="158.344" cy="87.9543" rx="2.20076" ry="2.13938" fill="white"/>
</g>



</svg>
''',
    frameSize: Size(864.0, 1833.0),
    screenSize: Size(540.0, 1080.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.android,
      DeviceType.tablet,
      'nexus9',
    ),
    name: 'Nexus 9',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 20.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 20.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: parseSvgPathData(
        'M117.061 276.197C117.061 275.093 117.957 274.197 119.061 274.197H1734.94C1736.04 274.197 1736.94 275.093 1736.94 276.197V2432.03C1736.94 2433.14 1736.04 2434.03 1734.94 2434.03H119.061C117.957 2434.03 117.061 2433.14 117.061 2432.03V276.197Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="1854" height="2722" viewBox="0 0 1854 2722" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_i" x="912.235" y="134.99" width="29.529" height="31.6382" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="2.10922"/>
<feGaussianBlur stdDeviation="2.10922"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.806499 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter1_i" x="912.235" y="134.99" width="29.529" height="39.0205" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="18.9829"/>
<feGaussianBlur stdDeviation="4.74573"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.344316 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter2_i" x="919.618" y="141.318" width="16.8737" height="16.8737" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="1.05461" dy="-1.05461"/>
<feGaussianBlur stdDeviation="1.05461"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.943444 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter3_i" x="912.235" y="134.727" width="29.529" height="29.7927" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-0.263652"/>
<feGaussianBlur stdDeviation="0.527304"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.199643 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter4_i" x="659.13" y="2678.7" width="531.522" height="13.7099" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-10.5461" dy="5.27304"/>
<feGaussianBlur stdDeviation="1.05461"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.539968 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter5_f" x="557.13" y="2673.2" width="776.652" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter6_f" x="557.13" y="2674.25" width="776.652" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter7_f" x="557.13" y="2674.25" width="776.652" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter8_f" x="556.075" y="2670.04" width="776.652" height="24.7164" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter9_i" x="659.13" y="17.9277" width="531.522" height="13.7099" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-10.5461" dy="5.27304"/>
<feGaussianBlur stdDeviation="1.05461"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.539968 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter10_f" x="557.13" y="12.4253" width="776.652" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter11_f" x="557.13" y="11.3706" width="776.652" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter12_f" x="557.13" y="11.3706" width="776.652" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter13_f" x="556.075" y="13.479" width="776.652" height="24.7164" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter14_f" x="557.13" y="12.4253" width="776.652" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter15_f" x="557.13" y="11.3706" width="776.652" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter16_f" x="557.13" y="11.3706" width="776.652" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter17_f" x="556.075" y="13.479" width="776.652" height="24.7164" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter18_f" x="557.13" y="11.3706" width="776.652" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter19_i" x="15.8191" y="-2.10922" width="1824.47" height="2709.29" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="6.32765" dy="-18.9829"/>
<feGaussianBlur stdDeviation="1.05461"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.853556 0 0 0 0 0.853556 0 0 0 0 0.853556 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter20_f" x="26.1211" y="-15.0104" width="1827" height="2631.25" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="7.50521" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter21_i" x="13.7099" y="0" width="1824.47" height="2708.76" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-2.10922" dy="1.58191"/>
<feGaussianBlur stdDeviation="1.05461"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.381369 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter22_i" x="15.8191" y="-3.16382" width="1824.47" height="2710.34" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="2.10922" dy="-4.21843"/>
<feGaussianBlur stdDeviation="1.58191"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.746264 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter23_i" x="912.235" y="134.99" width="29.529" height="39.0205" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="18.9829"/>
<feGaussianBlur stdDeviation="4.74573"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.344316 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter24_i" x="920.672" y="143.427" width="12.6553" height="13.7099" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.05461"/>
<feGaussianBlur stdDeviation="1.05461"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter25_f" x="915.697" y="139.506" width="22.6072" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter26_f" x="915.697" y="139.506" width="22.6072" height="22.6072" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.43336" result="effect1_foregroundBlur"/>
</filter>
<radialGradient id="paint0_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(675.685 2680.19) rotate(180) scale(149.261 1.36511)">
<stop stop-color="white"/>
<stop offset="0.885634" stop-color="#B6B0B0" stop-opacity="0.26"/>
<stop offset="1" stop-color="#9F9F9F" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint1_linear" x1="1268.02" y1="2651.64" x2="1267.51" y2="2680.17" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="0.885634" stop-color="white" stop-opacity="0.26"/>
<stop offset="1" stop-color="#9F9F9F" stop-opacity="0.01"/>
</linearGradient>
<radialGradient id="paint2_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(994.052 2671.33) rotate(-178.137) scale(242.734 7.78797)">
<stop stop-color="white" stop-opacity="0.3"/>
<stop offset="0.885634" stop-color="white" stop-opacity="0.26"/>
<stop offset="1" stop-color="#9F9F9F" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint3_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(675.685 28.044) rotate(180) scale(149.261 1.36511)">
<stop stop-color="white"/>
<stop offset="0.885634" stop-color="#B6B0B0" stop-opacity="0.26"/>
<stop offset="1" stop-color="#9F9F9F" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint4_linear" x1="1268.02" y1="56.597" x2="1267.51" y2="28.0647" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="0.885634" stop-color="white" stop-opacity="0.26"/>
<stop offset="1" stop-color="#9F9F9F" stop-opacity="0.01"/>
</linearGradient>
<radialGradient id="paint5_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(994.052 36.9065) rotate(178.137) scale(242.734 7.78797)">
<stop stop-color="white" stop-opacity="0.3"/>
<stop offset="0.885634" stop-color="white" stop-opacity="0.26"/>
<stop offset="1" stop-color="#9F9F9F" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint6_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(675.685 28.044) rotate(180) scale(149.261 1.36511)">
<stop stop-color="white"/>
<stop offset="0.885634" stop-color="#B6B0B0" stop-opacity="0.26"/>
<stop offset="1" stop-color="#9F9F9F" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint7_linear" x1="1268.02" y1="56.597" x2="1267.51" y2="28.0647" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="0.885634" stop-color="white" stop-opacity="0.26"/>
<stop offset="1" stop-color="#9F9F9F" stop-opacity="0.01"/>
</linearGradient>
<radialGradient id="paint8_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(994.052 36.9065) rotate(178.137) scale(242.734 7.78797)">
<stop stop-color="white" stop-opacity="0.3"/>
<stop offset="0.885634" stop-color="white" stop-opacity="0.26"/>
<stop offset="1" stop-color="#9F9F9F" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint9_linear" x1="1268.02" y1="56.597" x2="1267.51" y2="28.0647" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="0.885634" stop-color="white" stop-opacity="0.26"/>
<stop offset="1" stop-color="#9F9F9F" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint10_linear" x1="853.016" y1="-1483.11" x2="-1722.65" y2="593.878" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="1" stop-color="#B7B7B7"/>
</linearGradient>
<linearGradient id="paint11_linear" x1="1377.21" y1="-486.664" x2="870.121" y2="-248.026" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="1" stop-color="#B0B0B0" stop-opacity="0.0960994"/>
</linearGradient>
<linearGradient id="paint12_linear" x1="1772.78" y1="-164.207" x2="1527.11" y2="-36.5514" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.401042"/>
<stop offset="0.211765" stop-color="#777777" stop-opacity="0.785185"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</linearGradient>
<radialGradient id="paint13_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(919.636 160.098) rotate(41.5652) scale(17.1697 9.69274)">
<stop stop-color="white"/>
<stop offset="0.479691" stop-color="#DEDEDE" stop-opacity="0.698182"/>
<stop offset="1" stop-color="#929292" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint14_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(927 150.807) rotate(96.0287) scale(9.54582)">
<stop/>
<stop offset="1" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint15_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(927 149.754) rotate(90) scale(16.2386)">
<stop stop-color="#252B60"/>
<stop offset="1" stop-color="#292942"/>
</radialGradient>
<radialGradient id="paint16_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(924.748 152.572) rotate(90) scale(4.03141)">
<stop stop-color="#2E3F69"/>
<stop offset="0.50006" stop-color="#2C375C" stop-opacity="0.65346"/>
<stop offset="1" stop-color="#292942" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint17_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(925.78 151.745) rotate(90) scale(5.45387)">
<stop stop-color="#4C64A2"/>
<stop offset="0.589206" stop-color="#2C375C" stop-opacity="0.65346"/>
<stop offset="1" stop-color="#292942" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint18_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(929.093 148.437) rotate(33.34) scale(4.31773 2.55505)">
<stop stop-color="#ADA8E2"/>
<stop offset="0.539302" stop-color="#6B6799"/>
<stop offset="1" stop-color="#292942" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint19_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(929.093 148.437) rotate(33.34) scale(4.31773 2.55505)">
<stop stop-color="#ADA8E2"/>
<stop offset="0.539302" stop-color="#6B6799"/>
<stop offset="1" stop-color="#292942" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint20_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(925.78 151.745) rotate(90) scale(4.64848)">
<stop stop-color="#4C64A2"/>
<stop offset="0.589206" stop-color="#2C375C" stop-opacity="0.65346"/>
<stop offset="1" stop-color="#292942" stop-opacity="0.01"/>
</radialGradient>
<clipPath id="clip0">
<rect width="1854" height="2721.94" fill="white"/>
</clipPath>
<clipPath id="clip1">
<rect width="1822.36" height="2707.18" fill="white" transform="translate(15.8191)"/>
</clipPath>
<clipPath id="clip2">
<rect width="29.529" height="29.529" fill="white" transform="translate(912.235 134.99)"/>
</clipPath>
<clipPath id="clip3">
<rect width="771.973" height="18.9829" fill="white" transform="matrix(1 0 0 -1 558.942 2693.47)"/>
</clipPath>
<clipPath id="clip4">
<rect width="771.973" height="18.9829" fill="white" transform="matrix(1 0 0 -1 558.942 2693.47)"/>
</clipPath>
<clipPath id="clip5">
<rect width="771.973" height="18.9829" fill="white" transform="translate(558.942 14.7646)"/>
</clipPath>
<clipPath id="clip6">
<rect width="771.973" height="18.9829" fill="white" transform="translate(558.942 14.7646)"/>
</clipPath>
<clipPath id="clip7">
<rect width="771.973" height="18.9829" fill="white" transform="translate(558.942 14.7646)"/>
</clipPath>
<clipPath id="clip8">
<rect width="771.973" height="18.9829" fill="white" transform="translate(558.942 14.7646)"/>
</clipPath>
<clipPath id="clip9">
<rect width="1822.36" height="2707.18" fill="white" transform="translate(15.8191)"/>
</clipPath>
<clipPath id="clip10">
<rect width="29.529" height="29.529" fill="white" transform="translate(912.235 134.99)"/>
</clipPath>
</defs>
<g clip-path="url(#clip0)">
<g clip-path="url(#clip1)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M15.8191 78.5893C15.8191 35.1856 51.0048 0 94.4085 0H1759.59C1803 0 1838.18 35.1857 1838.18 78.5894V91.4466V2628.59C1838.18 2671.99 1803 2707.18 1759.59 2707.18H94.4084C51.0047 2707.18 15.8191 2671.99 15.8191 2628.59V78.5893Z" fill="#090909"/>
<g clip-path="url(#clip2)">
<g filter="url(#filter0_i)">
<circle cx="927" cy="149.755" r="14.7645" fill="#595959"/>
</g>
<g filter="url(#filter1_i)">
<circle cx="927" cy="149.755" r="14.7645" fill="black" fill-opacity="0.01"/>
</g>
<g filter="url(#filter2_i)">
<circle cx="927.527" cy="150.283" r="7.90956" fill="black" fill-opacity="0.01"/>
</g>
<circle cx="928.055" cy="149.754" r="5.27304" fill="black"/>
<g filter="url(#filter3_i)">
<circle cx="927" cy="149.755" r="14.7645" fill="black" fill-opacity="0.01"/>
</g>
</g>
<g clip-path="url(#clip3)">
<g filter="url(#filter4_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M661.239 2690.3H1190.65C1190.65 2690.3 1184.83 2678.7 1179.02 2678.7C1173.2 2678.7 684.51 2678.7 672.874 2678.7C665.457 2678.7 661.239 2690.3 661.239 2690.3Z" fill="#242424"/>
</g>
<g clip-path="url(#clip4)">
<g filter="url(#filter5_f)">
<path d="M559.997 2692.41C559.997 2692.41 653.857 2692.41 657.02 2692.41C660.184 2692.41 661.239 2689.25 662.294 2687.14C665.457 2681.87 666.512 2676.59 671.785 2676.59C704.478 2676.59 935.44 2677.65 935.44 2677.65C916.454 2677.65 1147.42 2676.59 1180.11 2676.59C1185.38 2676.59 1186.44 2681.87 1189.6 2687.14C1190.66 2689.25 1191.71 2692.41 1194.87 2692.41C1198.04 2692.41 1330.91 2692.41 1330.91 2692.41" stroke="url(#paint0_radial)" stroke-width="1.05461"/>
</g>
<g opacity="0.8" filter="url(#filter6_f)">
<path d="M559.997 2693.47C559.997 2693.47 653.857 2693.47 657.02 2693.47C660.184 2693.47 661.239 2690.3 662.294 2688.19C665.457 2682.92 666.512 2677.65 671.785 2677.65C704.478 2677.65 935.44 2678.7 935.44 2678.7C916.454 2678.7 1147.42 2677.65 1180.11 2677.65C1185.38 2677.65 1186.44 2682.92 1189.6 2688.19C1190.66 2690.3 1191.71 2693.47 1194.87 2693.47C1198.04 2693.47 1330.91 2693.47 1330.91 2693.47" stroke="url(#paint1_linear)" stroke-width="1.05461"/>
</g>
<g opacity="0.8" filter="url(#filter7_f)">
<path d="M559.997 2693.47C559.997 2693.47 653.857 2693.47 657.02 2693.47C660.184 2693.47 661.239 2690.3 662.294 2688.19C665.457 2682.92 666.512 2677.65 671.785 2677.65C704.478 2677.65 935.44 2678.7 935.44 2678.7C916.454 2678.7 1147.42 2677.65 1180.11 2677.65C1185.38 2677.65 1186.44 2682.92 1189.6 2688.19C1190.66 2690.3 1191.71 2693.47 1194.87 2693.47C1198.04 2693.47 1330.91 2693.47 1330.91 2693.47" stroke="url(#paint2_radial)" stroke-width="1.05461"/>
</g>
<g filter="url(#filter8_f)">
<path d="M558.942 2690.3C558.942 2690.3 652.802 2690.3 655.966 2690.3C659.13 2690.3 660.184 2687.14 661.239 2685.03C664.403 2679.76 665.457 2674.48 670.73 2674.48C703.423 2674.48 934.386 2675.54 934.386 2675.54C915.399 2675.54 1148.47 2674.48 1181.16 2674.48C1186.44 2674.48 1187.49 2679.76 1190.66 2685.03C1191.71 2687.14 1192.76 2690.3 1195.93 2690.3C1199.09 2690.3 1329.86 2690.3 1329.86 2690.3" stroke="black" stroke-width="3.16382"/>
</g>
</g>
</g>
<g clip-path="url(#clip5)">
<g filter="url(#filter9_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M661.239 17.9277H1190.65C1190.65 17.9277 1184.83 29.5284 1179.02 29.5284C1173.2 29.5284 684.51 29.5284 672.874 29.5284C665.457 29.5284 661.239 17.9277 661.239 17.9277Z" fill="#242424"/>
</g>
<g clip-path="url(#clip6)">
<g clip-path="url(#clip7)">
<g filter="url(#filter10_f)">
<path d="M559.997 15.8193C559.997 15.8193 653.857 15.8193 657.02 15.8193C660.184 15.8193 661.239 18.9832 662.294 21.0924C665.457 26.3654 666.512 31.6384 671.785 31.6384C704.478 31.6384 935.44 30.5838 935.44 30.5838C916.454 30.5838 1147.42 31.6384 1180.11 31.6384C1185.38 31.6384 1186.44 26.3654 1189.6 21.0924C1190.66 18.9832 1191.71 15.8193 1194.87 15.8193C1198.04 15.8193 1330.91 15.8193 1330.91 15.8193" stroke="url(#paint3_radial)" stroke-width="1.05461"/>
</g>
<g opacity="0.8" filter="url(#filter11_f)">
<path d="M559.997 14.7646C559.997 14.7646 653.857 14.7646 657.02 14.7646C660.184 14.7646 661.239 17.9285 662.294 20.0377C665.457 25.3107 666.512 30.5838 671.785 30.5838C704.478 30.5838 935.44 29.5292 935.44 29.5292C916.454 29.5292 1147.42 30.5838 1180.11 30.5838C1185.38 30.5838 1186.44 25.3107 1189.6 20.0377C1190.66 17.9285 1191.71 14.7646 1194.87 14.7646C1198.04 14.7646 1330.91 14.7646 1330.91 14.7646" stroke="url(#paint4_linear)" stroke-width="1.05461"/>
</g>
<g opacity="0.8" filter="url(#filter12_f)">
<path d="M559.997 14.7646C559.997 14.7646 653.857 14.7646 657.02 14.7646C660.184 14.7646 661.239 17.9285 662.294 20.0377C665.457 25.3107 666.512 30.5838 671.785 30.5838C704.478 30.5838 935.44 29.5292 935.44 29.5292C916.454 29.5292 1147.42 30.5838 1180.11 30.5838C1185.38 30.5838 1186.44 25.3107 1189.6 20.0377C1190.66 17.9285 1191.71 14.7646 1194.87 14.7646C1198.04 14.7646 1330.91 14.7646 1330.91 14.7646" stroke="url(#paint5_radial)" stroke-width="1.05461"/>
</g>
<g filter="url(#filter13_f)">
<path d="M558.942 17.9277C558.942 17.9277 652.802 17.9277 655.966 17.9277C659.13 17.9277 660.184 21.0916 661.239 23.2008C664.403 28.4738 665.457 33.7468 670.73 33.7468C703.423 33.7468 934.386 32.6922 934.386 32.6922C915.399 32.6922 1148.47 33.7468 1181.16 33.7468C1186.44 33.7468 1187.49 28.4738 1190.66 23.2008C1191.71 21.0916 1192.76 17.9277 1195.93 17.9277C1199.09 17.9277 1329.86 17.9277 1329.86 17.9277" stroke="black" stroke-width="3.16382"/>
</g>
</g>
<g opacity="0.1" clip-path="url(#clip8)">
<g filter="url(#filter14_f)">
<path d="M559.997 15.8193C559.997 15.8193 653.857 15.8193 657.02 15.8193C660.184 15.8193 661.239 18.9832 662.294 21.0924C665.457 26.3654 666.512 31.6384 671.785 31.6384C704.478 31.6384 935.44 30.5838 935.44 30.5838C916.454 30.5838 1147.42 31.6384 1180.11 31.6384C1185.38 31.6384 1186.44 26.3654 1189.6 21.0924C1190.66 18.9832 1191.71 15.8193 1194.87 15.8193C1198.04 15.8193 1330.91 15.8193 1330.91 15.8193" stroke="url(#paint6_radial)" stroke-width="1.05461"/>
</g>
<g opacity="0.8" filter="url(#filter15_f)">
<path d="M559.997 14.7646C559.997 14.7646 653.857 14.7646 657.02 14.7646C660.184 14.7646 661.239 17.9285 662.294 20.0377C665.457 25.3107 666.512 30.5838 671.785 30.5838C704.478 30.5838 935.44 29.5292 935.44 29.5292C916.454 29.5292 1147.42 30.5838 1180.11 30.5838C1185.38 30.5838 1186.44 25.3107 1189.6 20.0377C1190.66 17.9285 1191.71 14.7646 1194.87 14.7646C1198.04 14.7646 1330.91 14.7646 1330.91 14.7646" stroke="url(#paint7_linear)" stroke-width="1.05461"/>
</g>
<g opacity="0.8" filter="url(#filter16_f)">
<path d="M559.997 14.7646C559.997 14.7646 653.857 14.7646 657.02 14.7646C660.184 14.7646 661.239 17.9285 662.294 20.0377C665.457 25.3107 666.512 30.5838 671.785 30.5838C704.478 30.5838 935.44 29.5292 935.44 29.5292C916.454 29.5292 1147.42 30.5838 1180.11 30.5838C1185.38 30.5838 1186.44 25.3107 1189.6 20.0377C1190.66 17.9285 1191.71 14.7646 1194.87 14.7646C1198.04 14.7646 1330.91 14.7646 1330.91 14.7646" stroke="url(#paint8_radial)" stroke-width="1.05461"/>
</g>
<g filter="url(#filter17_f)">
<path d="M558.942 17.9277C558.942 17.9277 652.802 17.9277 655.966 17.9277C659.13 17.9277 660.184 21.0916 661.239 23.2008C664.403 28.4738 665.457 33.7468 670.73 33.7468C703.423 33.7468 934.386 32.6922 934.386 32.6922C915.399 32.6922 1148.47 33.7468 1181.16 33.7468C1186.44 33.7468 1187.49 28.4738 1190.66 23.2008C1191.71 21.0916 1192.76 17.9277 1195.93 17.9277C1199.09 17.9277 1329.86 17.9277 1329.86 17.9277" stroke="black" stroke-width="3.16382"/>
</g>
<g opacity="0.8" filter="url(#filter18_f)">
<path d="M559.997 14.7646C559.997 14.7646 653.857 14.7646 657.02 14.7646C660.184 14.7646 661.239 17.9285 662.294 20.0377C665.457 25.3107 666.512 30.5838 671.785 30.5838C704.478 30.5838 935.44 29.5292 935.44 29.5292C916.454 29.5292 1147.42 30.5838 1180.11 30.5838C1185.38 30.5838 1186.44 25.3107 1189.6 20.0377C1190.66 17.9285 1191.71 14.7646 1194.87 14.7646C1198.04 14.7646 1330.91 14.7646 1330.91 14.7646" stroke="url(#paint9_linear)" stroke-width="1.05461"/>
</g>
</g>
</g>
</g>
<g clip-path="url(#clip9)">
<g filter="url(#filter19_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1826.54 37.4059C1812.7 14.9628 1787.89 0 1759.58 0H94.4159C50.9991 0 15.8191 35.1901 15.8191 78.5993V2628.58C15.8191 2671.99 51.0081 2707.18 94.4159 2707.18H1759.58C1803 2707.18 1838.18 2671.99 1838.18 2628.58V91.4466V78.5868C1838.18 63.4878 1833.92 49.3819 1826.54 37.4059C1826.54 74.511 1826.54 132.942 1826.54 169.259V2628.58C1826.54 2665.56 1796.56 2695.53 1759.6 2695.53H94.4017C57.4328 2695.53 27.4636 2665.56 27.4636 2628.58V78.5942C27.4636 41.6185 57.4444 11.6438 94.4017 11.6438H1759.6C1796.57 11.6438 1826.54 41.6119 1826.54 78.5875V37.4059Z" fill="url(#paint10_linear)"/>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M41.1247 20.7532C50.1297 16.2463 60.2925 13.7101 71.0476 13.7101H1759.52C1796.49 13.7101 1826.46 43.6831 1826.46 80.6566V105.157V2601.23C1833.85 2589.25 1838.11 2575.14 1838.11 2560.04V89.131V78.5893C1838.11 35.1856 1802.92 0 1759.52 0H94.335C73.8099 0 55.1225 7.86834 41.1247 20.7532Z" fill="url(#paint11_linear)" fill-opacity="0.9"/>
<g filter="url(#filter20_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M41.1315 20.7532C50.1365 16.2463 60.2992 13.7101 71.0543 13.7101H1759.52C1796.5 13.7101 1826.47 43.6831 1826.47 80.6566V105.157V2601.23C1833.85 2589.25 1838.11 2575.14 1838.11 2560.04V89.131V78.5893C1838.11 35.1856 1802.93 0 1759.52 0H94.3417C73.8166 0 55.1293 7.86832 41.1315 20.7532Z" fill="url(#paint12_linear)" fill-opacity="0.5"/>
</g>
<g filter="url(#filter21_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M15.8191 74.8772C15.8191 33.5237 49.3428 0 90.6963 0H1763.3C1804.66 0 1838.18 33.5236 1838.18 74.8771V91.4466V2632.3C1838.18 2673.65 1804.66 2707.18 1763.3 2707.18H90.6962C49.3427 2707.18 15.8191 2673.65 15.8191 2632.3V74.8772Z" fill="black" fill-opacity="0.01"/>
</g>
<g filter="url(#filter22_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M15.8191 78.5893C15.8191 35.1856 51.0048 0 94.4085 0H1759.59C1803 0 1838.18 35.1857 1838.18 78.5894V91.4466V2628.59C1838.18 2671.99 1803 2707.18 1759.59 2707.18H94.4084C51.0047 2707.18 15.8191 2671.99 15.8191 2628.59V78.5893Z" fill="black" fill-opacity="0.01"/>
</g>
</g>
<g clip-path="url(#clip10)">
<circle cx="927" cy="149.755" r="14.7645" fill="#111111"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M927 164.519C935.154 164.519 941.764 157.909 941.764 149.755C941.764 141.601 935.154 134.99 927 134.99C918.846 134.99 912.235 141.601 912.235 149.755C912.235 157.909 918.846 164.519 927 164.519ZM927 156.082C930.495 156.082 933.328 153.249 933.328 149.755C933.328 146.26 930.495 143.427 927 143.427C923.505 143.427 920.672 146.26 920.672 149.755C920.672 153.249 923.505 156.082 927 156.082Z" fill="url(#paint13_radial)" fill-opacity="0.4" style="mix-blend-mode:screen"/>
<g opacity="0.4" filter="url(#filter23_i)">
<circle cx="927" cy="149.755" r="14.7645" fill="black" fill-opacity="0.01"/>
</g>
<circle cx="927" cy="149.754" r="10.5461" fill="url(#paint14_radial)"/>
<g filter="url(#filter24_i)">
<circle cx="927" cy="149.754" r="6.32765" fill="url(#paint15_radial)"/>
</g>
<circle cx="922.782" cy="155.028" r="8.43686" fill="url(#paint16_radial)" fill-opacity="0.7"/>
<circle cx="923.836" cy="153.973" r="8.43686" fill="url(#paint17_radial)" fill-opacity="0.9"/>
<g filter="url(#filter25_f)">
<circle cx="927" cy="150.81" r="8.43686" fill="url(#paint18_radial)" fill-opacity="0.9" style="mix-blend-mode:color-dodge"/>
</g>
<g filter="url(#filter26_f)">
<circle cx="927" cy="150.81" r="8.43686" fill="url(#paint19_radial)" fill-opacity="0.9" style="mix-blend-mode:color-dodge"/>
</g>
<circle cx="923.836" cy="153.973" r="8.43686" fill="url(#paint20_radial)" fill-opacity="0.9"/>
</g>
<rect x="114.952" y="272.089" width="1624.1" height="2164.05" rx="2.10922" fill="#121212"/>
</g>


</g>

</svg>
''',
    frameSize: Size(1854.0, 2722.0),
    screenSize: Size(768.0, 1024.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.android,
      DeviceType.phone,
      'android-16-9-aspect-ratio',
    ),
    name: 'Android Phone 16_9',
    pixelRatio: 3.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          0.0,
          0.0,
          414.0,
          736.0,
        ),
      ),
    svgFrame:
        '''<svg width="414" height="736" viewBox="0 0 414 736" fill="none" xmlns="http://www.w3.org/2000/svg">
	<!-- SCREEN SHAPE -->
	
	<!-- DEVICE PROPERTIES -->
	
</svg>
''',
    frameSize: Size(414.0, 736.0),
    screenSize: Size(414.0, 736.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.android,
      DeviceType.tablet,
      'android-7-inch',
    ),
    name: 'Android Tablet 7"',
    pixelRatio: 3.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          0.0,
          0.0,
          576.0,
          1024.0,
        ),
      ),
    svgFrame:
        '''<svg width="576" height="1024" viewBox="0 0 576 1024" fill="none" xmlns="http://www.w3.org/2000/svg">
	<!-- SCREEN SHAPE -->
	
	<!-- DEVICE PROPERTIES -->
	
</svg>
''',
    frameSize: Size(576.0, 1024.0),
    screenSize: Size(576.0, 1024.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.iOS,
      DeviceType.phone,
      'iphone-5-5-inch',
    ),
    name: 'iPhone 5.5"',
    pixelRatio: 3.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          0.0,
          0.0,
          414.0,
          736.0,
        ),
      ),
    svgFrame:
        '''<svg width="414" height="736" viewBox="0 0 414 736" fill="none" xmlns="http://www.w3.org/2000/svg">
	<!-- SCREEN SHAPE -->
	
	<!-- DEVICE PROPERTIES -->
	
</svg>
''',
    frameSize: Size(414.0, 736.0),
    screenSize: Size(414.0, 736.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.iOS,
      DeviceType.tablet,
      'ipad-mini',
    ),
    name: 'iPad Mini',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 20.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 20.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          69.2434,
          201.239,
          1107.9,
          1477.2,
        ),
      ),
    svgFrame:
        '''<svg width="1247" height="1881" viewBox="0 0 1247 1881" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_i" x="0" y="0" width="1246.38" height="1880.4" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.721287"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter1_d" x="11.5406" y="11.5406" width="1223.3" height="1857.31" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.360643"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.557681 0 0 0 0 0.56321 0 0 0 0 0.585326 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter2_i" x="574.144" y="1741.91" width="98.8163" height="98.095" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="0.721287"/>
<feGaussianBlur stdDeviation="0.360643"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.112687 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter3_d" x="612.231" y="91.6033" width="22.4797" height="23.1765" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="0.721287"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.133333 0 0 0 0 0.133333 0 0 0 0 0.133333 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter4_d" x="615.262" y="94.6275" width="16.4186" height="16.407" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="1.44257" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.721287"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter5_f" x="624.177" y="97.593" width="5.6968" height="5.6968" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.980331" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter6_f" x="619.439" y="98.7726" width="8.17422" height="8.17422" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.980331" result="effect1_foregroundBlur"/>
</filter>
<linearGradient id="paint0_linear" x1="13.394" y1="40.4146" x2="13.394" y2="1880.4" gradientUnits="userSpaceOnUse">
<stop stop-color="#4C4D50" stop-opacity="0.01"/>
<stop offset="0.0362117" stop-color="#4C4D50"/>
<stop offset="0.446329" stop-color="#4C4D50" stop-opacity="0.01"/>
<stop offset="0.941095" stop-color="#4C4D50" stop-opacity="0.907892"/>
<stop offset="1" stop-color="#4C4D50" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint1_linear" x1="1246.38" y1="-1.94409" x2="0" y2="-1.94409" gradientUnits="userSpaceOnUse">
<stop stop-color="#4C4D50" stop-opacity="0.01"/>
<stop offset="0.507121" stop-color="#4C4D50" stop-opacity="0.5"/>
<stop offset="1" stop-color="#4C4D50" stop-opacity="0.01"/>
</linearGradient>
<radialGradient id="paint2_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(623.192 1790.96) scale(49.0475)">
<stop offset="0.138428" stop-color="#67666C"/>
<stop offset="0.200569" stop-color="#090A10"/>
<stop offset="0.293609" stop-color="#1D1E23"/>
<stop offset="0.321076" stop-color="#4C4B50"/>
<stop offset="0.423219" stop-color="#7F7E84"/>
<stop offset="0.501325" stop-color="#B5B5B5"/>
<stop offset="0.524768" stop-color="#090A10"/>
<stop offset="0.71246" stop-color="#151419"/>
<stop offset="0.726278" stop-color="#4D4C51"/>
<stop offset="0.769684" stop-color="#504F54"/>
<stop offset="0.777708" stop-color="#3A393E"/>
<stop offset="0.879251" stop-color="#151519"/>
<stop offset="0.926482" stop-color="#100F14"/>
<stop offset="0.950315" stop-color="#5B5C62"/>
</radialGradient>
<radialGradient id="paint3_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(639.445 121.722) rotate(45.1627) scale(22.616 22.6161)">
<stop stop-color="white"/>
<stop offset="1" stop-color="#252525"/>
</radialGradient>
<linearGradient id="paint4_linear" x1="623.471" y1="86.876" x2="623.471" y2="108.149" gradientUnits="userSpaceOnUse">
<stop stop-color="#2A4893"/>
<stop offset="1" stop-color="#213054"/>
</linearGradient>
</defs>
<g filter="url(#filter0_i)">
<path d="M112.124 0H1134.26C1167.77 0 1183.61 3.0583 1200.05 11.8539C1214.88 19.7859 1226.6 31.499 1234.53 46.3305C1243.33 62.7768 1246.38 78.614 1246.38 112.124V1768.27C1246.38 1801.78 1243.33 1817.62 1234.53 1834.06C1226.6 1848.9 1214.88 1860.61 1200.05 1868.54C1183.61 1877.34 1167.77 1880.4 1134.26 1880.4H112.124C78.614 1880.4 62.7768 1877.34 46.3305 1868.54C31.499 1860.61 19.7859 1848.9 11.8539 1834.06C3.0583 1817.62 0 1801.78 0 1768.27V112.124C0 78.614 3.0583 62.7768 11.8539 46.3305C19.7859 31.499 31.499 19.7859 46.3305 11.8539C62.7768 3.0583 78.614 0 112.124 0Z" fill="#9FA0A7"/>
<path d="M112.124 0H1134.26C1167.77 0 1183.61 3.0583 1200.05 11.8539C1214.88 19.7859 1226.6 31.499 1234.53 46.3305C1243.33 62.7768 1246.38 78.614 1246.38 112.124V1768.27C1246.38 1801.78 1243.33 1817.62 1234.53 1834.06C1226.6 1848.9 1214.88 1860.61 1200.05 1868.54C1183.61 1877.34 1167.77 1880.4 1134.26 1880.4H112.124C78.614 1880.4 62.7768 1877.34 46.3305 1868.54C31.499 1860.61 19.7859 1848.9 11.8539 1834.06C3.0583 1817.62 0 1801.78 0 1768.27V112.124C0 78.614 3.0583 62.7768 11.8539 46.3305C19.7859 31.499 31.499 19.7859 46.3305 11.8539C62.7768 3.0583 78.614 0 112.124 0Z" fill="url(#paint0_linear)"/>
<path d="M112.124 0H1134.26C1167.77 0 1183.61 3.0583 1200.05 11.8539C1214.88 19.7859 1226.6 31.499 1234.53 46.3305C1243.33 62.7768 1246.38 78.614 1246.38 112.124V1768.27C1246.38 1801.78 1243.33 1817.62 1234.53 1834.06C1226.6 1848.9 1214.88 1860.61 1200.05 1868.54C1183.61 1877.34 1167.77 1880.4 1134.26 1880.4H112.124C78.614 1880.4 62.7768 1877.34 46.3305 1868.54C31.499 1860.61 19.7859 1848.9 11.8539 1834.06C3.0583 1817.62 0 1801.78 0 1768.27V112.124C0 78.614 3.0583 62.7768 11.8539 46.3305C19.7859 31.499 31.499 19.7859 46.3305 11.8539C62.7768 3.0583 78.614 0 112.124 0Z" fill="url(#paint1_linear)"/>
</g>
<g filter="url(#filter1_d)">
<path d="M112.124 12.2618C77.3997 12.2618 64.8079 15.8774 52.1132 22.6665C39.4186 29.4557 29.4557 39.4185 22.6666 52.1132C15.8774 64.8078 12.2619 77.3997 12.2619 112.124V1768.27C12.2619 1803 15.8774 1815.59 22.6666 1828.28C29.4557 1840.98 39.4186 1850.94 52.1132 1857.73C64.8079 1864.52 77.3997 1868.13 112.124 1868.13H1134.26C1168.98 1868.13 1181.58 1864.52 1194.27 1857.73C1206.97 1850.94 1216.93 1840.98 1223.72 1828.28C1230.51 1815.59 1234.12 1803 1234.12 1768.27V112.124C1234.12 77.3997 1230.51 64.8078 1223.72 52.1132C1216.93 39.4185 1206.97 29.4557 1194.27 22.6665C1181.58 15.8774 1168.98 12.2618 1134.26 12.2618H112.124Z" fill="#0F0F0F"/>
</g>
<g filter="url(#filter2_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M623.192 1840C650.28 1840 672.239 1818.04 672.239 1790.96C672.239 1763.87 650.28 1741.91 623.192 1741.91C596.104 1741.91 574.144 1763.87 574.144 1790.96C574.144 1818.04 596.104 1840 623.192 1840ZM623.526 1833.33C647.113 1833.33 666.234 1814.21 666.234 1790.62C666.234 1767.03 647.113 1747.91 623.526 1747.91C599.939 1747.91 580.818 1767.03 580.818 1790.62C580.818 1814.21 599.939 1833.33 623.526 1833.33Z" fill="url(#paint2_angular)"/>
</g>
<g filter="url(#filter3_d)">
<ellipse cx="623.471" cy="102.831" rx="11.2398" ry="11.2276" fill="url(#paint3_radial)"/>
</g>
<g filter="url(#filter4_d)">
<ellipse cx="623.471" cy="102.831" rx="5.32413" ry="5.31835" fill="url(#paint4_linear)"/>
</g>
<g filter="url(#filter5_f)">
<circle cx="627.026" cy="100.441" r="0.887738" fill="#75C8FF"/>
</g>
<g filter="url(#filter6_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M624.112 104.903C625.241 104.58 625.894 103.402 625.57 102.274C625.246 101.145 624.069 100.493 622.94 100.816C621.812 101.14 621.159 102.317 621.483 103.446C621.806 104.574 622.984 105.227 624.112 104.903Z" fill="#00154F"/>
</g>
<path d="M64.9158 199.091V1680.58C64.9158 1681.78 65.8937 1682.76 67.0999 1682.76H1179.28C1180.49 1682.76 1181.47 1681.79 1181.47 1680.58V199.091C1181.47 197.89 1180.49 196.911 1179.28 196.911H67.0999C65.8968 196.911 64.9158 197.887 64.9158 199.091Z" fill="#212121"/>



</svg>
''',
    frameSize: Size(1247.0, 1881.0),
    screenSize: Size(768.0, 1024.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.macOS,
      DeviceType.desktop,
      'imac-pro',
    ),
    name: 'iMac Pro',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.zero,
    rotatedSafeAreas: null,
    screenPath: parseSvgPathData(
        'M380.847 289.72H2168.5V1317.55C2168.5 1321.02 2165.69 1323.84 2162.21 1323.84H387.131C383.66 1323.84 380.847 1321.02 380.847 1317.55V289.72Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="2536" height="2096" viewBox="0 0 2536 2096" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_d" x="882.048" y="2079.18" width="771.11" height="16.8226" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.454664"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.061849 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter1_d" x="1258.68" y="36.5455" width="13.7497" height="13.7497" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="0.909328" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.454664"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter2_f" x="1268.03" y="38.4766" width="4.49428" height="4.49428" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.617952" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter3_f" x="1268.03" y="38.4766" width="4.49428" height="4.49428" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.617952" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter4_f" x="1260.85" y="38.0418" width="6.71505" height="5.36388" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.617952" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter5_f" x="1262.63" y="39.8244" width="7.19212" height="7.19212" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.617952" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter6_f" x="1263.8" y="42.741" width="3.82012" height="3.82012" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.617952" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter7_ddd" x="310.538" y="202.678" width="1928.58" height="1205.23" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="14.0618"/>
<feGaussianBlur stdDeviation="35.1544"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="28.1236"/>
<feGaussianBlur stdDeviation="21.0927"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.703089"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.9 0"/>
<feBlend mode="normal" in2="effect2_dropShadow" result="effect3_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect3_dropShadow" result="shape"/>
</filter>
<filter id="filter8_ii" x="380.846" y="258.222" width="1787.97" height="32.3421" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-0.703089"/>
<feGaussianBlur stdDeviation="0.351544"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.703089"/>
<feGaussianBlur stdDeviation="0.351544"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.6 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter9_bdd" x="66.9498" y="72.6059" width="2399.42" height="99.0499" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feGaussianBlur in="BackgroundImage" stdDeviation="17.4303"/>
<feComposite in2="SourceAlpha" operator="in" result="effect1_backgroundBlur"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="10.2596"/>
<feGaussianBlur stdDeviation="12.8245"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/>
<feBlend mode="normal" in2="effect1_backgroundBlur" result="effect2_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="0.641225"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect2_dropShadow" result="effect3_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect3_dropShadow" result="shape"/>
</filter>
<linearGradient id="paint0_linear" x1="882.048" y1="1742.73" x2="882.048" y2="2094.18" gradientUnits="userSpaceOnUse">
<stop stop-color="#242328"/>
<stop offset="0.190646" stop-color="#2C2B30"/>
<stop offset="0.387487" stop-color="#4B4A4F"/>
<stop offset="0.421228" stop-color="#555459"/>
<stop offset="0.583651" stop-color="#727076"/>
<stop offset="0.665405" stop-color="#434248"/>
<stop offset="0.744936" stop-color="#26252A"/>
<stop offset="0.80397" stop-color="#313035"/>
<stop offset="0.980985" stop-color="#3F3F43"/>
<stop offset="0.988443" stop-color="#343338"/>
<stop offset="1" stop-color="#D2D3D5"/>
<stop offset="1" stop-color="#2B2A2F"/>
</linearGradient>
<radialGradient id="paint1_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(944.318 2063.28) rotate(16.4906) scale(108.853 83.4256)">
<stop stop-color="#E9EAEC"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint2_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1596.18 2060.92) rotate(63.1632) scale(96.4324 243.602)">
<stop stop-color="#E9EAEC"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint3_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1000.66 2081.68) rotate(98.4617) scale(78.8069 447.419)">
<stop stop-color="white" stop-opacity="0.818784"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint4_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1536.83 2081.77) rotate(81.7234) scale(75.2373 404.11)">
<stop stop-color="white" stop-opacity="0.82"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint5_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1653.16 2087.64) rotate(147.343) scale(179.495 127.224)">
<stop stop-color="white"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint6_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(882.048 2080.75) rotate(117.573) scale(129.905 417.74)">
<stop stop-color="white"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint7_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1260.86 2039.62) rotate(90) scale(60.4028 656.097)">
<stop stop-color="#343338"/>
<stop offset="1" stop-color="#2D2C31" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint8_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1277.53 1742.73) rotate(90) scale(196.446 634.905)">
<stop stop-color="#27262B"/>
<stop offset="1" stop-color="#2D2C31" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint9_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(969.585 1951.37) rotate(103.127) scale(77.171 633.515)">
<stop stop-color="#27262B"/>
<stop offset="1" stop-color="#2D2C31" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint10_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1558.64 1951.68) rotate(77.0406) scale(70.1351 553.176)">
<stop stop-color="#27262B"/>
<stop offset="1" stop-color="#2D2C31" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint11_linear" x1="886.889" y1="2099.14" x2="1648.25" y2="2099.14" gradientUnits="userSpaceOnUse">
<stop stop-color="#838385"/>
<stop offset="0.0182458" stop-color="#C1C0C6"/>
<stop offset="0.0375704" stop-color="#27262B"/>
<stop offset="0.504551" stop-color="#2B2A2F"/>
<stop offset="0.965588" stop-color="#2F2E33"/>
<stop offset="0.985363" stop-color="#C1C0C6"/>
<stop offset="1" stop-color="#838385"/>
</linearGradient>
<linearGradient id="paint12_linear" x1="0" y1="1743.18" x2="2535.21" y2="1743.18" gradientUnits="userSpaceOnUse">
<stop stop-color="#29282D"/>
<stop offset="1" stop-color="#404044"/>
</linearGradient>
<radialGradient id="paint13_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1252.75 61.3403) rotate(116.906) scale(17.9971)">
<stop stop-color="white"/>
<stop offset="0.0281362" stop-color="#CECECE" stop-opacity="0.767503"/>
<stop offset="1" stop-color="#252525"/>
</radialGradient>
<radialGradient id="paint14_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1265.56 38.3641) rotate(90) scale(10.1123)">
<stop stop-color="#2F2E32"/>
<stop offset="1" stop-color="#101518"/>
</radialGradient>
<radialGradient id="paint15_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1265.51 41.7965) rotate(90) scale(3.72804)">
<stop stop-color="#101722"/>
<stop offset="1" stop-color="#525669"/>
</radialGradient>
<linearGradient id="paint16_linear" x1="1267.6" y1="109.574" x2="1267.6" y2="1419.01" gradientUnits="userSpaceOnUse">
<stop stop-color="#221D29"/>
<stop offset="1" stop-color="#293251"/>
</linearGradient>
<linearGradient id="paint17_linear" x1="380.846" y1="258.925" x2="380.846" y2="289.861" gradientUnits="userSpaceOnUse">
<stop stop-color="#E7E6E7"/>
<stop offset="1" stop-color="#E1E1E1"/>
</linearGradient>
<clipPath id="clip0">
<rect width="1787.97" height="1064.61" fill="white" transform="translate(380.846 258.925)"/>
</clipPath>
<clipPath id="clip1">
<rect width="1787.97" height="30.9359" fill="white" transform="translate(380.846 258.925)"/>
</clipPath>
<clipPath id="clip2">
<rect width="2331.58" height="28.2807" fill="white" transform="translate(101.81 107.467)"/>
</clipPath>
<clipPath id="clip3">
<rect width="274.444" height="20.5192" fill="white" transform="translate(2129.45 111.314)"/>
</clipPath>
<clipPath id="clip4">
<rect width="459.117" height="21.8017" fill="white" transform="translate(128.742 110.031)"/>
</clipPath>
</defs>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1016.62 1742.73C1016.62 1742.73 1003.37 1972.98 982.215 2004.11C970.852 2020.83 894.288 2067.41 885.928 2074.42C877.568 2081.44 885.321 2083.23 885.321 2083.23C885.321 2083.23 910.064 2091.89 937.913 2093.71C955.547 2094.85 974.023 2093.55 987.337 2093.66C1027.71 2093.99 1108.47 2093.73 1108.47 2093.73H1426.73C1426.73 2093.73 1507.49 2093.99 1547.86 2093.66C1561.18 2093.55 1579.65 2094.85 1597.29 2093.71C1625.14 2091.89 1649.9 2083.67 1649.9 2083.67C1649.9 2083.67 1657.63 2081.44 1649.27 2074.42C1640.91 2067.41 1564.35 2020.83 1552.99 2004.11C1531.83 1972.98 1518.58 1742.73 1518.58 1742.73H1448.79H1098.92H1016.62Z" fill="url(#paint0_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1016.62 1742.73C1016.62 1742.73 1003.37 1972.98 982.215 2004.11C970.852 2020.83 894.288 2067.41 885.928 2074.42C877.568 2081.44 885.321 2083.23 885.321 2083.23C885.321 2083.23 910.064 2091.89 937.913 2093.71C955.547 2094.85 974.023 2093.55 987.337 2093.66C1027.71 2093.99 1108.47 2093.73 1108.47 2093.73H1426.73C1426.73 2093.73 1507.49 2093.99 1547.86 2093.66C1561.18 2093.55 1579.65 2094.85 1597.29 2093.71C1625.14 2091.89 1649.9 2083.67 1649.9 2083.67C1649.9 2083.67 1657.63 2081.44 1649.27 2074.42C1640.91 2067.41 1564.35 2020.83 1552.99 2004.11C1531.83 1972.98 1518.58 1742.73 1518.58 1742.73H1448.79H1098.92H1016.62Z" fill="url(#paint1_radial)" style="mix-blend-mode:soft-light"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1016.62 1742.73C1016.62 1742.73 1003.37 1972.98 982.215 2004.11C970.852 2020.83 894.288 2067.41 885.928 2074.42C877.568 2081.44 885.321 2083.23 885.321 2083.23C885.321 2083.23 910.064 2091.89 937.913 2093.71C955.547 2094.85 974.023 2093.55 987.337 2093.66C1027.71 2093.99 1108.47 2093.73 1108.47 2093.73H1426.73C1426.73 2093.73 1507.49 2093.99 1547.86 2093.66C1561.18 2093.55 1579.65 2094.85 1597.29 2093.71C1625.14 2091.89 1649.9 2083.67 1649.9 2083.67C1649.9 2083.67 1657.63 2081.44 1649.27 2074.42C1640.91 2067.41 1564.35 2020.83 1552.99 2004.11C1531.83 1972.98 1518.58 1742.73 1518.58 1742.73H1448.79H1098.92H1016.62Z" fill="url(#paint2_radial)" style="mix-blend-mode:soft-light"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1016.62 1742.73C1016.62 1742.73 1003.37 1972.98 982.215 2004.11C970.852 2020.83 894.288 2067.41 885.928 2074.42C877.568 2081.44 885.321 2083.23 885.321 2083.23C885.321 2083.23 910.064 2091.89 937.913 2093.71C955.547 2094.85 974.023 2093.55 987.337 2093.66C1027.71 2093.99 1108.47 2093.73 1108.47 2093.73H1426.73C1426.73 2093.73 1507.49 2093.99 1547.86 2093.66C1561.18 2093.55 1579.65 2094.85 1597.29 2093.71C1625.14 2091.89 1649.9 2083.67 1649.9 2083.67C1649.9 2083.67 1657.63 2081.44 1649.27 2074.42C1640.91 2067.41 1564.35 2020.83 1552.99 2004.11C1531.83 1972.98 1518.58 1742.73 1518.58 1742.73H1448.79H1098.92H1016.62Z" fill="url(#paint3_radial)" style="mix-blend-mode:soft-light"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1016.62 1742.73C1016.62 1742.73 1003.37 1972.98 982.215 2004.11C970.852 2020.83 894.288 2067.41 885.928 2074.42C877.568 2081.44 885.321 2083.23 885.321 2083.23C885.321 2083.23 910.064 2091.89 937.913 2093.71C955.547 2094.85 974.023 2093.55 987.337 2093.66C1027.71 2093.99 1108.47 2093.73 1108.47 2093.73H1426.73C1426.73 2093.73 1507.49 2093.99 1547.86 2093.66C1561.18 2093.55 1579.65 2094.85 1597.29 2093.71C1625.14 2091.89 1649.9 2083.67 1649.9 2083.67C1649.9 2083.67 1657.63 2081.44 1649.27 2074.42C1640.91 2067.41 1564.35 2020.83 1552.99 2004.11C1531.83 1972.98 1518.58 1742.73 1518.58 1742.73H1448.79H1098.92H1016.62Z" fill="url(#paint4_radial)" style="mix-blend-mode:soft-light"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1016.62 1742.73C1016.62 1742.73 1003.37 1972.98 982.215 2004.11C970.852 2020.83 894.288 2067.41 885.928 2074.42C877.568 2081.44 885.321 2083.23 885.321 2083.23C885.321 2083.23 910.064 2091.89 937.913 2093.71C955.547 2094.85 974.023 2093.55 987.337 2093.66C1027.71 2093.99 1108.47 2093.73 1108.47 2093.73H1426.73C1426.73 2093.73 1507.49 2093.99 1547.86 2093.66C1561.18 2093.55 1579.65 2094.85 1597.29 2093.71C1625.14 2091.89 1649.9 2083.67 1649.9 2083.67C1649.9 2083.67 1657.63 2081.44 1649.27 2074.42C1640.91 2067.41 1564.35 2020.83 1552.99 2004.11C1531.83 1972.98 1518.58 1742.73 1518.58 1742.73H1448.79H1098.92H1016.62Z" fill="url(#paint5_radial)" fill-opacity="0.4" style="mix-blend-mode:luminosity"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1016.62 1742.73C1016.62 1742.73 1003.37 1972.98 982.215 2004.11C970.852 2020.83 894.288 2067.41 885.928 2074.42C877.568 2081.44 885.321 2083.23 885.321 2083.23C885.321 2083.23 910.064 2091.89 937.913 2093.71C955.547 2094.85 974.023 2093.55 987.337 2093.66C1027.71 2093.99 1108.47 2093.73 1108.47 2093.73H1426.73C1426.73 2093.73 1507.49 2093.99 1547.86 2093.66C1561.18 2093.55 1579.65 2094.85 1597.29 2093.71C1625.14 2091.89 1649.9 2083.67 1649.9 2083.67C1649.9 2083.67 1657.63 2081.44 1649.27 2074.42C1640.91 2067.41 1564.35 2020.83 1552.99 2004.11C1531.83 1972.98 1518.58 1742.73 1518.58 1742.73H1448.79H1098.92H1016.62Z" fill="url(#paint6_radial)" fill-opacity="0.4" style="mix-blend-mode:luminosity"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1016.62 1742.73C1016.62 1742.73 1003.37 1972.98 982.215 2004.11C970.852 2020.83 894.288 2067.41 885.928 2074.42C877.568 2081.44 885.321 2083.23 885.321 2083.23C885.321 2083.23 910.064 2091.89 937.913 2093.71C955.547 2094.85 974.023 2093.55 987.337 2093.66C1027.71 2093.99 1108.47 2093.73 1108.47 2093.73H1426.73C1426.73 2093.73 1507.49 2093.99 1547.86 2093.66C1561.18 2093.55 1579.65 2094.85 1597.29 2093.71C1625.14 2091.89 1649.9 2083.67 1649.9 2083.67C1649.9 2083.67 1657.63 2081.44 1649.27 2074.42C1640.91 2067.41 1564.35 2020.83 1552.99 2004.11C1531.83 1972.98 1518.58 1742.73 1518.58 1742.73H1448.79H1098.92H1016.62Z" fill="url(#paint7_radial)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1016.62 1742.73C1016.62 1742.73 1003.37 1972.98 982.215 2004.11C970.852 2020.83 894.288 2067.41 885.928 2074.42C877.568 2081.44 885.321 2083.23 885.321 2083.23C885.321 2083.23 910.064 2091.89 937.913 2093.71C955.547 2094.85 974.023 2093.55 987.337 2093.66C1027.71 2093.99 1108.47 2093.73 1108.47 2093.73H1426.73C1426.73 2093.73 1507.49 2093.99 1547.86 2093.66C1561.18 2093.55 1579.65 2094.85 1597.29 2093.71C1625.14 2091.89 1649.9 2083.67 1649.9 2083.67C1649.9 2083.67 1657.63 2081.44 1649.27 2074.42C1640.91 2067.41 1564.35 2020.83 1552.99 2004.11C1531.83 1972.98 1518.58 1742.73 1518.58 1742.73H1448.79H1098.92H1016.62Z" fill="url(#paint8_radial)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1016.62 1742.73C1016.62 1742.73 1003.37 1972.98 982.215 2004.11C970.852 2020.83 894.288 2067.41 885.928 2074.42C877.568 2081.44 885.321 2083.23 885.321 2083.23C885.321 2083.23 910.064 2091.89 937.913 2093.71C955.547 2094.85 974.023 2093.55 987.337 2093.66C1027.71 2093.99 1108.47 2093.73 1108.47 2093.73H1426.73C1426.73 2093.73 1507.49 2093.99 1547.86 2093.66C1561.18 2093.55 1579.65 2094.85 1597.29 2093.71C1625.14 2091.89 1649.9 2083.67 1649.9 2083.67C1649.9 2083.67 1657.63 2081.44 1649.27 2074.42C1640.91 2067.41 1564.35 2020.83 1552.99 2004.11C1531.83 1972.98 1518.58 1742.73 1518.58 1742.73H1448.79H1098.92H1016.62Z" fill="url(#paint9_radial)" fill-opacity="0.2"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1016.62 1742.73C1016.62 1742.73 1003.37 1972.98 982.215 2004.11C970.852 2020.83 894.288 2067.41 885.928 2074.42C877.568 2081.44 885.321 2083.23 885.321 2083.23C885.321 2083.23 910.064 2091.89 937.913 2093.71C955.547 2094.85 974.023 2093.55 987.337 2093.66C1027.71 2093.99 1108.47 2093.73 1108.47 2093.73H1426.73C1426.73 2093.73 1507.49 2093.99 1547.86 2093.66C1561.18 2093.55 1579.65 2094.85 1597.29 2093.71C1625.14 2091.89 1649.9 2083.67 1649.9 2083.67C1649.9 2083.67 1657.63 2081.44 1649.27 2074.42C1640.91 2067.41 1564.35 2020.83 1552.99 2004.11C1531.83 1972.98 1518.58 1742.73 1518.58 1742.73H1448.79H1098.92H1016.62Z" fill="url(#paint10_radial)" fill-opacity="0.2"/>
<g filter="url(#filter0_d)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1584.39 2089.74C1640.02 2089.74 1652.79 2079.7 1652.79 2079.7C1652.99 2079.56 1653.16 2079.65 1653.16 2079.89V2083.03C1653.16 2084.01 1652.52 2085.3 1651.67 2085.84C1651.67 2085.84 1641.21 2096 1581.59 2096H1531.99H1009.35H953.615C893.999 2096 883.535 2085.84 883.535 2085.84C882.688 2085.3 882.048 2084.01 882.048 2083.03L882.048 2079.89C882.048 2079.65 882.214 2079.56 882.418 2079.7C882.418 2079.7 895.184 2089.74 950.815 2089.74H1009.35H1531.99H1584.39Z" fill="url(#paint11_linear)"/>
</g>
<path d="M0 1511.3H2535.21V1652.98C2535.21 1684.55 2535.21 1700.34 2529.06 1712.4C2523.66 1723.01 2515.03 1731.63 2504.42 1737.04C2492.36 1743.18 2476.57 1743.18 2445 1743.18H90.2054C58.6305 1743.18 42.8431 1743.18 30.7831 1737.04C20.1748 1731.63 11.55 1723.01 6.14487 1712.4C0 1700.34 0 1684.55 0 1652.98V1511.3Z" fill="url(#paint12_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1268.58 1596.45C1272.55 1596.45 1279.92 1590.99 1289.52 1590.99C1306.03 1590.99 1312.53 1602.74 1312.53 1602.74C1312.53 1602.74 1299.82 1609.24 1299.82 1625C1299.82 1642.78 1315.65 1648.9 1315.65 1648.9C1315.65 1648.9 1304.59 1680.04 1289.64 1680.04C1282.78 1680.04 1277.44 1675.41 1270.21 1675.41C1262.83 1675.41 1255.52 1680.21 1250.75 1680.21C1237.11 1680.21 1219.86 1650.68 1219.86 1626.93C1219.86 1603.57 1234.46 1591.32 1248.15 1591.32C1257.05 1591.32 1263.95 1596.45 1268.58 1596.45Z" fill="black"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1272.72 1572.97C1280.44 1562.8 1291.17 1562.75 1291.17 1562.75C1291.17 1562.75 1292.76 1572.31 1285.1 1581.52C1276.91 1591.36 1267.6 1589.75 1267.6 1589.75C1267.6 1589.75 1265.85 1582.02 1272.72 1572.97Z" fill="black"/>
<path d="M0 97.4799C0 63.3588 0 46.2982 6.64042 33.2656C12.4815 21.8018 21.8018 12.4815 33.2656 6.64042C46.2982 0 63.3587 0 97.4799 0H2437.73C2471.85 0 2488.91 0 2501.94 6.64042C2513.4 12.4815 2522.72 21.8018 2528.56 33.2656C2535.21 46.2982 2535.21 63.3587 2535.21 97.4799V1511.3H0V97.4799Z" fill="#030303"/>
<g opacity="0.703683">
<circle cx="1265.56" cy="43.4204" r="9.77527" fill="url(#paint13_radial)"/>
<g filter="url(#filter1_d)">
<circle cx="1265.56" cy="43.4203" r="5.05617" fill="url(#paint14_radial)"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="1260" y="38" width="11" height="11">
<circle cx="1265.56" cy="43.4203" r="5.05617" fill="white"/>
</mask>
<g mask="url(#mask0)">
<g filter="url(#filter2_f)">
<circle cx="1270.28" cy="40.7238" r="1.01123" fill="#2F3046"/>
</g>
<g filter="url(#filter3_f)">
<circle cx="1270.28" cy="40.7238" r="1.01123" fill="#21271B"/>
</g>
<g filter="url(#filter4_f)">
<ellipse cx="1264.21" cy="40.7238" rx="2.35955" ry="1.01123" transform="rotate(-29 1264.21 40.7238)" fill="#323137"/>
</g>
<g filter="url(#filter5_f)">
<circle cx="1266.23" cy="43.4205" r="2.35955" transform="rotate(-16 1266.23 43.4205)" fill="url(#paint15_radial)"/>
</g>
<g filter="url(#filter6_f)">
<circle cx="1265.71" cy="44.6511" r="0.674157" fill="#505760"/>
</g>
</g>
</g>
<rect x="101.845" y="107.755" width="2331.52" height="1313.07" fill="#202020"/>
<rect x="103.663" y="109.574" width="2327.88" height="1309.43" fill="url(#paint16_linear)"/>
<g clip-path="url(#clip0)">
<g filter="url(#filter7_ddd)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M387.877 258.925C383.994 258.925 380.846 262.073 380.846 265.956V1316.5C380.846 1320.39 383.994 1323.54 387.877 1323.54H2161.78C2165.67 1323.54 2168.81 1320.39 2168.81 1316.5V265.956C2168.81 262.073 2165.67 258.925 2161.78 258.925H387.877Z" fill="#ECECEC"/>
</g>
<g clip-path="url(#clip1)">
<g filter="url(#filter8_ii)">
<path d="M380.846 265.956C380.846 262.073 383.994 258.925 387.877 258.925H2161.78C2165.67 258.925 2168.81 262.073 2168.81 265.956V289.861H380.846V265.956Z" fill="url(#paint17_linear)"/>
</g>
<circle cx="400.533" cy="274.393" r="8.08552" fill="#FF5F58" stroke="#E1483F" stroke-width="0.703089"/>
<circle cx="428.657" cy="274.393" r="8.08552" fill="#D1D1D1" stroke="#B1B1B1" stroke-width="0.703089"/>
<circle cx="456.781" cy="274.393" r="8.08552" fill="#D1D1D1" stroke="#B1B1B1" stroke-width="0.703089"/>
</g>


</g>
<g clip-path="url(#clip2)">
<g filter="url(#filter9_bdd)">
<rect x="101.81" y="107.467" width="2329.7" height="28.2807" fill="#FAFAFA" fill-opacity="0.8"/>
</g>
<g clip-path="url(#clip3)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M2403.9 115.161H2385.94V117.726H2403.9V115.161ZM2383.38 115.161H2380.81V117.726H2383.38V115.161ZM2380.81 120.291H2383.38V122.856H2380.81V120.291ZM2400.05 120.291H2385.94V122.856H2400.05V120.291ZM2380.81 125.421H2383.38V127.986H2380.81V125.421ZM2403.9 125.421H2385.94V127.986H2403.9V125.421Z" fill="black" fill-opacity="0.75"/>
<g opacity="0.8">
<circle cx="2349.39" cy="119.65" r="6.09164" stroke="black" stroke-width="1.92368"/>
<path d="M2359.65 129.909L2353.88 124.138" stroke="black" stroke-width="1.92368" stroke-linecap="round" stroke-linejoin="round"/>
</g>
<g opacity="0.8">
<path d="M2243.4 114.889L2247.57 125.304L2251.75 114.889H2253.93V127.654H2252.25V122.683L2252.4 117.318L2248.21 127.654H2246.93L2242.74 117.344L2242.91 122.683V127.654H2241.23V114.889H2243.4Z" fill="black"/>
<path d="M2255.91 122.823C2255.91 121.894 2256.09 121.058 2256.45 120.316C2256.82 119.574 2257.33 119.001 2257.98 118.598C2258.63 118.195 2259.38 117.993 2260.21 117.993C2261.51 117.993 2262.55 118.44 2263.34 119.334C2264.15 120.228 2264.55 121.418 2264.55 122.902V123.016C2264.55 123.94 2264.37 124.77 2264.01 125.506C2263.66 126.237 2263.15 126.806 2262.49 127.215C2261.84 127.625 2261.09 127.829 2260.23 127.829C2258.95 127.829 2257.9 127.382 2257.1 126.488C2256.31 125.594 2255.91 124.41 2255.91 122.937V122.823ZM2257.54 123.016C2257.54 124.068 2257.78 124.913 2258.27 125.55C2258.76 126.187 2259.41 126.505 2260.23 126.505C2261.06 126.505 2261.71 126.184 2262.2 125.541C2262.68 124.892 2262.92 123.986 2262.92 122.823C2262.92 121.783 2262.68 120.941 2262.18 120.299C2261.69 119.65 2261.03 119.325 2260.21 119.325C2259.41 119.325 2258.77 119.644 2258.28 120.281C2257.79 120.918 2257.54 121.83 2257.54 123.016Z" fill="black"/>
<path d="M2266.31 126.803C2266.31 126.523 2266.39 126.289 2266.55 126.102C2266.72 125.915 2266.97 125.822 2267.31 125.822C2267.64 125.822 2267.89 125.915 2268.06 126.102C2268.24 126.289 2268.32 126.523 2268.32 126.803C2268.32 127.072 2268.24 127.297 2268.06 127.478C2267.89 127.66 2267.64 127.75 2267.31 127.75C2266.97 127.75 2266.72 127.66 2266.55 127.478C2266.39 127.297 2266.31 127.072 2266.31 126.803Z" fill="black"/>
<path d="M2282.68 122.21C2282.68 124.109 2282.36 125.521 2281.71 126.444C2281.06 127.367 2280.05 127.829 2278.67 127.829C2277.3 127.829 2276.3 127.379 2275.64 126.479C2274.99 125.573 2274.65 124.223 2274.62 122.429V120.263C2274.62 118.387 2274.95 116.993 2275.6 116.082C2276.25 115.17 2277.26 114.714 2278.65 114.714C2280.02 114.714 2281.03 115.155 2281.68 116.038C2282.33 116.915 2282.66 118.27 2282.68 120.106V122.21ZM2281.06 119.992C2281.06 118.618 2280.87 117.619 2280.48 116.993C2280.09 116.362 2279.48 116.047 2278.65 116.047C2277.82 116.047 2277.21 116.359 2276.83 116.985C2276.45 117.61 2276.26 118.571 2276.25 119.869V122.464C2276.25 123.843 2276.44 124.863 2276.84 125.524C2277.25 126.178 2277.85 126.505 2278.67 126.505C2279.47 126.505 2280.06 126.196 2280.45 125.576C2280.84 124.957 2281.04 123.981 2281.06 122.648V119.992Z" fill="black"/>
<path d="M2290.67 122.043C2290.33 122.446 2289.92 122.771 2289.45 123.016C2288.98 123.262 2288.47 123.384 2287.9 123.384C2287.17 123.384 2286.53 123.203 2285.98 122.841C2285.43 122.479 2285.01 121.97 2284.71 121.315C2284.42 120.655 2284.27 119.927 2284.27 119.133C2284.27 118.279 2284.43 117.511 2284.75 116.827C2285.08 116.143 2285.54 115.62 2286.13 115.258C2286.73 114.895 2287.43 114.714 2288.22 114.714C2289.48 114.714 2290.48 115.188 2291.2 116.134C2291.93 117.075 2292.3 118.361 2292.3 119.992V120.465C2292.3 122.949 2291.81 124.764 2290.82 125.909C2289.84 127.049 2288.36 127.633 2286.38 127.663H2286.06V126.295H2286.41C2287.74 126.272 2288.77 125.924 2289.49 125.252C2290.21 124.574 2290.6 123.504 2290.67 122.043ZM2288.17 122.043C2288.71 122.043 2289.21 121.877 2289.67 121.543C2290.13 121.21 2290.46 120.798 2290.68 120.307V119.659C2290.68 118.595 2290.44 117.73 2289.98 117.064C2289.52 116.397 2288.94 116.064 2288.23 116.064C2287.52 116.064 2286.94 116.339 2286.51 116.888C2286.08 117.432 2285.86 118.151 2285.86 119.045C2285.86 119.916 2286.07 120.635 2286.48 121.202C2286.91 121.763 2287.47 122.043 2288.17 122.043Z" fill="black"/>
<path d="M2294.34 126.803C2294.34 126.523 2294.42 126.289 2294.58 126.102C2294.75 125.915 2295.01 125.822 2295.34 125.822C2295.67 125.822 2295.92 125.915 2296.09 126.102C2296.27 126.289 2296.36 126.523 2296.36 126.803C2296.36 127.072 2296.27 127.297 2296.09 127.478C2295.92 127.66 2295.67 127.75 2295.34 127.75C2295.01 127.75 2294.75 127.66 2294.58 127.478C2294.42 127.297 2294.34 127.072 2294.34 126.803ZM2294.35 119.062C2294.35 118.782 2294.43 118.548 2294.59 118.361C2294.76 118.174 2295.01 118.081 2295.35 118.081C2295.68 118.081 2295.93 118.174 2296.1 118.361C2296.28 118.548 2296.36 118.782 2296.36 119.062C2296.36 119.331 2296.28 119.556 2296.1 119.737C2295.93 119.919 2295.68 120.009 2295.35 120.009C2295.01 120.009 2294.76 119.919 2294.59 119.737C2294.43 119.556 2294.35 119.331 2294.35 119.062Z" fill="black"/>
<path d="M2305.11 123.367H2306.88V124.691H2305.11V127.654H2303.48V124.691H2297.67V123.735L2303.39 114.889H2305.11V123.367ZM2299.51 123.367H2303.48V117.107L2303.29 117.458L2299.51 123.367Z" fill="black"/>
<path d="M2313.37 127.654H2311.74V116.844L2308.47 118.045V116.573L2313.12 114.828H2313.37V127.654Z" fill="black"/>
</g>
<g opacity="0.8">
<path fill-rule="evenodd" clip-rule="evenodd" d="M2201.27 119.009C2201.27 118.3 2201.85 117.726 2202.55 117.726H2206.4L2211.53 113.879V129.268L2206.4 125.421H2202.55C2201.85 125.421 2201.27 124.847 2201.27 124.138V119.009Z" fill="black"/>
<path d="M2218.98 127.986C2220.6 126.251 2221.6 123.892 2221.6 121.293C2221.6 118.654 2220.57 116.262 2218.91 114.52" stroke="black" stroke-width="1.28245" stroke-linecap="round"/>
<path d="M2214.74 126.062C2215.92 124.913 2216.66 123.307 2216.66 121.53C2216.66 119.797 2215.96 118.227 2214.83 117.085" stroke="black" stroke-width="1.28245" stroke-linecap="round"/>
</g>
<path d="M2187.34 117.529C2184.61 114.472 2180.91 112.596 2176.85 112.596C2172.75 112.596 2169.04 114.497 2166.3 117.59" stroke="black" stroke-width="1.53894" stroke-linecap="square"/>
<path d="M2184.3 121.204C2182.35 119.047 2179.73 117.726 2176.85 117.726C2173.97 117.726 2171.35 119.042 2169.4 121.19" stroke="black" stroke-width="1.53894" stroke-linecap="square"/>
<path d="M2181.21 124.82C2180.05 123.599 2178.52 122.856 2176.85 122.856C2175.19 122.856 2173.67 123.586 2172.52 124.788" stroke="black" stroke-width="1.53894" stroke-linecap="square"/>
<ellipse cx="2176.83" cy="128.948" rx="2.17224" ry="1.60306" fill="black"/>
</g>
<g clip-path="url(#clip4)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M140.089 113.252C140.875 112.399 141.307 111.226 141.239 110.031C140.169 110.031 138.928 110.657 138.143 111.579C137.529 112.342 136.869 113.537 137.108 114.732C138.211 114.868 139.406 114.174 140.089 113.252ZM141.137 114.994C139.475 114.994 138.007 115.915 137.222 115.915C136.402 115.915 135.207 114.948 133.864 114.994C132.112 115.028 130.507 116.063 129.608 117.588C128.971 118.681 128.72 119.967 128.743 121.276C128.777 123.745 129.745 126.317 130.883 127.956C131.759 129.208 132.749 130.551 134.149 130.551C135.412 130.551 135.879 129.709 137.529 129.709C139.065 129.709 139.543 130.551 140.875 130.551C142.275 130.551 143.196 129.276 144.027 128.013C145.074 126.545 145.427 125.145 145.473 125.088C145.427 125.088 142.787 124.018 142.684 120.968C142.684 118.294 144.858 117.088 144.949 117.031C143.765 115.21 141.854 114.994 141.137 114.994Z" fill="#474747"/>
<path d="M180.222 122.168H175.085V127.577H172.867V114.813H180.976V116.601H175.085V120.397H180.222V122.168Z" fill="#484848"/>
<path d="M184.491 127.577H182.36V118.092H184.491V127.577ZM182.229 115.628C182.229 115.301 182.331 115.029 182.536 114.813C182.746 114.597 183.044 114.489 183.43 114.489C183.816 114.489 184.114 114.597 184.324 114.813C184.534 115.029 184.64 115.301 184.64 115.628C184.64 115.95 184.534 116.219 184.324 116.435C184.114 116.645 183.816 116.75 183.43 116.75C183.044 116.75 182.746 116.645 182.536 116.435C182.331 116.219 182.229 115.95 182.229 115.628Z" fill="#484848"/>
<path d="M188.777 127.577H186.646V114.112H188.777V127.577Z" fill="#484848"/>
<path d="M194.974 127.753C193.624 127.753 192.528 127.329 191.686 126.481C190.85 125.628 190.433 124.494 190.433 123.08V122.817C190.433 121.87 190.614 121.026 190.976 120.283C191.344 119.535 191.859 118.954 192.519 118.539C193.179 118.124 193.916 117.916 194.728 117.916C196.02 117.916 197.016 118.328 197.718 119.152C198.425 119.977 198.778 121.143 198.778 122.65V123.51H192.58C192.645 124.293 192.905 124.912 193.361 125.368C193.822 125.824 194.401 126.052 195.096 126.052C196.072 126.052 196.867 125.657 197.481 124.868L198.629 125.964C198.25 126.531 197.741 126.972 197.104 127.288C196.473 127.598 195.763 127.753 194.974 127.753ZM194.719 119.626C194.135 119.626 193.662 119.83 193.299 120.24C192.943 120.649 192.715 121.218 192.615 121.949H196.674V121.791C196.628 121.078 196.438 120.541 196.105 120.178C195.771 119.81 195.31 119.626 194.719 119.626Z" fill="#484848"/>
<path d="M228.615 121.879H223.372V125.806H229.5V127.577H221.154V114.813H229.439V116.601H223.372V120.126H228.615V121.879Z" fill="#484848"/>
<path d="M230.218 122.764C230.218 121.303 230.557 120.131 231.235 119.249C231.913 118.361 232.822 117.916 233.962 117.916C234.967 117.916 235.779 118.267 236.399 118.968V114.112H238.529V127.577H236.6L236.495 126.595C235.858 127.367 235.008 127.753 233.944 127.753C232.834 127.753 231.933 127.306 231.244 126.411C230.56 125.517 230.218 124.301 230.218 122.764ZM232.348 122.948C232.348 123.913 232.533 124.667 232.901 125.21C233.275 125.748 233.804 126.017 234.488 126.017C235.358 126.017 235.995 125.628 236.399 124.851V120.801C236.007 120.041 235.376 119.661 234.505 119.661C233.815 119.661 233.284 119.936 232.91 120.485C232.535 121.029 232.348 121.85 232.348 122.948Z" fill="#484848"/>
<path d="M242.71 127.577H240.579V118.092H242.71V127.577ZM240.448 115.628C240.448 115.301 240.55 115.029 240.755 114.813C240.965 114.597 241.263 114.489 241.649 114.489C242.035 114.489 242.333 114.597 242.543 114.813C242.754 115.029 242.859 115.301 242.859 115.628C242.859 115.95 242.754 116.219 242.543 116.435C242.333 116.645 242.035 116.75 241.649 116.75C241.263 116.75 240.965 116.645 240.755 116.435C240.55 116.219 240.448 115.95 240.448 115.628Z" fill="#484848"/>
<path d="M247.399 115.786V118.092H249.074V119.67H247.399V124.965C247.399 125.327 247.469 125.59 247.609 125.754C247.756 125.912 248.013 125.991 248.381 125.991C248.626 125.991 248.875 125.961 249.126 125.903V127.551C248.641 127.685 248.173 127.753 247.723 127.753C246.087 127.753 245.269 126.85 245.269 125.044V119.67H243.708V118.092H245.269V115.786H247.399Z" fill="#484848"/>
<path d="M275.92 124.798L279.164 114.813H281.601L277.007 127.577H274.86L270.283 114.813H272.712L275.92 124.798Z" fill="#484848"/>
<path d="M284.8 127.577H282.67V118.092H284.8V127.577ZM282.538 115.628C282.538 115.301 282.641 115.029 282.845 114.813C283.056 114.597 283.354 114.489 283.739 114.489C284.125 114.489 284.423 114.597 284.634 114.813C284.844 115.029 284.949 115.301 284.949 115.628C284.949 115.95 284.844 116.219 284.634 116.435C284.423 116.645 284.125 116.75 283.739 116.75C283.354 116.75 283.056 116.645 282.845 116.435C282.641 116.219 282.538 115.95 282.538 115.628Z" fill="#484848"/>
<path d="M290.997 127.753C289.647 127.753 288.551 127.329 287.71 126.481C286.874 125.628 286.456 124.494 286.456 123.08V122.817C286.456 121.87 286.637 121.026 287 120.283C287.368 119.535 287.882 118.954 288.543 118.539C289.203 118.124 289.939 117.916 290.752 117.916C292.043 117.916 293.04 118.328 293.741 119.152C294.448 119.977 294.802 121.143 294.802 122.65V123.51H288.604C288.668 124.293 288.928 124.912 289.384 125.368C289.846 125.824 290.424 126.052 291.12 126.052C292.096 126.052 292.891 125.657 293.505 124.868L294.653 125.964C294.273 126.531 293.765 126.972 293.128 127.288C292.496 127.598 291.786 127.753 290.997 127.753ZM290.743 119.626C290.159 119.626 289.685 119.83 289.323 120.24C288.966 120.649 288.738 121.218 288.639 121.949H292.698V121.791C292.651 121.078 292.461 120.541 292.128 120.178C291.795 119.81 291.333 119.626 290.743 119.626Z" fill="#484848"/>
<path d="M304.488 124.64L305.996 118.092H308.074L305.488 127.577H303.734L301.701 121.064L299.702 127.577H297.948L295.353 118.092H297.431L298.965 124.57L300.911 118.092H302.516L304.488 124.64Z" fill="#484848"/>
<path d="M340.225 124.421L342.188 114.813H344.389L341.443 127.577H339.322L336.893 118.258L334.412 127.577H332.282L329.336 114.813H331.537L333.518 124.404L335.955 114.813H337.814L340.225 124.421Z" fill="#484848"/>
<path d="M347.763 127.577H345.633V118.092H347.763V127.577ZM345.501 115.628C345.501 115.301 345.604 115.029 345.808 114.813C346.019 114.597 346.317 114.489 346.702 114.489C347.088 114.489 347.386 114.597 347.597 114.813C347.807 115.029 347.912 115.301 347.912 115.628C347.912 115.95 347.807 116.219 347.597 116.435C347.386 116.645 347.088 116.75 346.702 116.75C346.317 116.75 346.019 116.645 345.808 116.435C345.604 116.219 345.501 115.95 345.501 115.628Z" fill="#484848"/>
<path d="M351.76 118.092L351.821 119.188C352.523 118.34 353.443 117.916 354.583 117.916C356.558 117.916 357.563 119.047 357.598 121.309V127.577H355.468V121.432C355.468 120.83 355.337 120.386 355.074 120.099C354.816 119.807 354.393 119.661 353.802 119.661C352.943 119.661 352.303 120.05 351.883 120.827V127.577H349.752V118.092H351.76Z" fill="#484848"/>
<path d="M359.07 122.764C359.07 121.303 359.409 120.131 360.087 119.249C360.765 118.361 361.674 117.916 362.814 117.916C363.819 117.916 364.631 118.267 365.251 118.968V114.112H367.381V127.577H365.453L365.347 126.595C364.71 127.367 363.86 127.753 362.796 127.753C361.686 127.753 360.786 127.306 360.096 126.411C359.412 125.517 359.07 124.301 359.07 122.764ZM361.201 122.948C361.201 123.913 361.385 124.667 361.753 125.21C362.127 125.748 362.656 126.017 363.34 126.017C364.211 126.017 364.848 125.628 365.251 124.851V120.801C364.859 120.041 364.228 119.661 363.357 119.661C362.668 119.661 362.136 119.936 361.762 120.485C361.388 121.029 361.201 121.85 361.201 122.948Z" fill="#484848"/>
<path d="M368.897 122.747C368.897 121.818 369.081 120.982 369.449 120.24C369.817 119.491 370.335 118.919 371.001 118.521C371.667 118.118 372.433 117.916 373.298 117.916C374.578 117.916 375.615 118.328 376.41 119.152C377.211 119.977 377.643 121.069 377.707 122.431L377.716 122.931C377.716 123.866 377.535 124.702 377.173 125.438C376.816 126.175 376.302 126.744 375.63 127.148C374.963 127.551 374.192 127.753 373.315 127.753C371.977 127.753 370.904 127.308 370.098 126.42C369.297 125.526 368.897 124.337 368.897 122.852V122.747ZM371.027 122.931C371.027 123.907 371.229 124.673 371.632 125.228C372.035 125.777 372.596 126.052 373.315 126.052C374.034 126.052 374.592 125.771 374.99 125.21C375.393 124.649 375.595 123.828 375.595 122.747C375.595 121.788 375.387 121.029 374.972 120.467C374.563 119.906 374.005 119.626 373.298 119.626C372.602 119.626 372.05 119.903 371.641 120.459C371.232 121.008 371.027 121.832 371.027 122.931Z" fill="#484848"/>
<path d="M387.543 124.64L389.051 118.092H391.128L388.542 127.577H386.789L384.755 121.064L382.756 127.577H381.003L378.408 118.092H380.486L382.02 124.57L383.966 118.092H385.57L387.543 124.64Z" fill="#484848"/>
<path d="M423.402 127.577H421.193V121.905H415.486V127.577H413.268V114.813H415.486V120.126H421.193V114.813H423.402V127.577Z" fill="#484848"/>
<path d="M429.695 127.753C428.345 127.753 427.25 127.329 426.408 126.481C425.572 125.628 425.154 124.494 425.154 123.08V122.817C425.154 121.87 425.335 121.026 425.698 120.283C426.066 119.535 426.58 118.954 427.241 118.539C427.901 118.124 428.638 117.916 429.45 117.916C430.742 117.916 431.738 118.328 432.439 119.152C433.147 119.977 433.5 121.143 433.5 122.65V123.51H427.302C427.366 124.293 427.626 124.912 428.082 125.368C428.544 125.824 429.123 126.052 429.818 126.052C430.794 126.052 431.589 125.657 432.203 124.868L433.351 125.964C432.971 126.531 432.463 126.972 431.826 127.288C431.195 127.598 430.484 127.753 429.695 127.753ZM429.441 119.626C428.857 119.626 428.383 119.83 428.021 120.24C427.664 120.649 427.437 121.218 427.337 121.949H431.396V121.791C431.349 121.078 431.159 120.541 430.826 120.178C430.493 119.81 430.031 119.626 429.441 119.626Z" fill="#484848"/>
<path d="M437.12 127.577H434.99V114.112H437.12V127.577Z" fill="#484848"/>
<path d="M447.446 122.931C447.446 124.398 447.113 125.57 446.447 126.446C445.781 127.317 444.886 127.753 443.764 127.753C442.724 127.753 441.891 127.411 441.266 126.727V131.224H439.135V118.092H441.099L441.187 119.056C441.812 118.296 442.662 117.916 443.738 117.916C444.895 117.916 445.801 118.349 446.456 119.214C447.116 120.073 447.446 121.268 447.446 122.799V122.931ZM445.325 122.747C445.325 121.8 445.135 121.049 444.755 120.494C444.381 119.939 443.843 119.661 443.142 119.661C442.271 119.661 441.646 120.02 441.266 120.739V124.947C441.651 125.684 442.283 126.052 443.159 126.052C443.837 126.052 444.366 125.78 444.746 125.237C445.132 124.687 445.325 123.857 445.325 122.747Z" fill="#484848"/>
</g>
</g>

</svg>
''',
    frameSize: Size(2536.0, 2096.0),
    screenSize: Size(1422.0, 822.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.windows,
      DeviceType.desktop,
      'screen',
    ),
    name: 'Windows Screen',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: null,
    screenPath: parseSvgPathData('M502 306.047H2380V1439.51H502V306.047Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="2881" height="2032" viewBox="0 0 2881 2032" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_iii" x="1001.05" y="2001.97" width="60.9305" height="6.21891" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="1.03623"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.231686 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="0.62174"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.613026 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.24348"/>
<feGaussianBlur stdDeviation="0.207247"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.449643 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter1_iii" x="1400.21" y="2001.97" width="80.8262" height="8.29137" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="1.03623"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.231686 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="0.62174"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.613026 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.24348"/>
<feGaussianBlur stdDeviation="0.207247"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.449643 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter2_iii" x="1818.02" y="2001.97" width="60.9316" height="6.21891" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="1.03623"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.231686 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="0.62174"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.613026 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.24348"/>
<feGaussianBlur stdDeviation="0.207247"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.449643 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter3_ii" x="960.858" y="1980.43" width="959.093" height="21.9531" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="4.14493"/>
<feGaussianBlur stdDeviation="1.24348"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.502293 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-4.14493"/>
<feGaussianBlur stdDeviation="1.24348"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.502293 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter4_d" x="962.663" y="1917.41" width="955.539" height="63.832" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.24348"/>
<feGaussianBlur stdDeviation="0.207247"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.101591 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter5_i" x="0" y="0" width="2880.82" height="1730.92" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.528204"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.253255 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter6_di" x="9.50768" y="9.50695" width="2861.81" height="1711.91" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.264102"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.247934 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.264102"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.386634 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
</filter>
<linearGradient id="paint0_linear" x1="1061.98" y1="1999.69" x2="1001.05" y2="1999.69" gradientUnits="userSpaceOnUse">
<stop stop-color="#1D1D1D"/>
<stop offset="0.173469" stop-color="#363636"/>
<stop offset="0.306202" stop-color="#242424"/>
<stop offset="0.575627" stop-color="#474747"/>
<stop offset="1"/>
</linearGradient>
<linearGradient id="paint1_linear" x1="1481.03" y1="1998.65" x2="1400.21" y2="1998.65" gradientUnits="userSpaceOnUse">
<stop stop-color="#1D1D1D"/>
<stop offset="0.173469" stop-color="#363636"/>
<stop offset="0.306202" stop-color="#242424"/>
<stop offset="0.575627" stop-color="#474747"/>
<stop offset="1"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="1878.95" y1="1999.69" x2="1818.02" y2="1999.69" gradientUnits="userSpaceOnUse">
<stop stop-color="#1D1D1D"/>
<stop offset="0.173469" stop-color="#363636"/>
<stop offset="0.306202" stop-color="#242424"/>
<stop offset="0.575627" stop-color="#474747"/>
<stop offset="1"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="989.967" y1="2002.08" x2="1917.46" y2="2002.08" gradientUnits="userSpaceOnUse">
<stop stop-color="#2A2A2A"/>
<stop offset="0.498645" stop-color="#393939"/>
<stop offset="1" stop-color="#2C2C2C"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="1201.88" y1="1991.41" x2="1201.88" y2="2002.38" gradientUnits="userSpaceOnUse">
<stop stop-opacity="0.01"/>
<stop offset="1" stop-opacity="0.37316"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="1917.8" y1="1932.49" x2="963.077" y2="1932.49" gradientUnits="userSpaceOnUse">
<stop stop-color="#494949"/>
<stop offset="0.00548826" stop-color="#E4E4E4"/>
<stop offset="0.0146788" stop-color="white"/>
<stop offset="0.0262518" stop-color="#ECECEC"/>
<stop offset="0.035185" stop-color="#9C9C9C"/>
<stop offset="0.0428973" stop-color="#6C6B6B"/>
<stop offset="0.0502683" stop-color="#6E6E6E"/>
<stop offset="0.0606556" stop-color="#868686"/>
<stop offset="0.0960526" stop-color="#E2E2E2"/>
<stop offset="0.907582" stop-color="#E2E2E2"/>
<stop offset="0.941267" stop-color="#858585"/>
<stop offset="0.959083" stop-color="#777777"/>
<stop offset="0.97214" stop-color="#CBCBCB"/>
<stop offset="0.98448" stop-color="white"/>
<stop offset="0.993451" stop-color="#E4E4E4"/>
<stop offset="1" stop-color="#1C1C1C"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="1955.7" y1="1922.35" x2="1569.48" y2="1451.3" gradientUnits="userSpaceOnUse">
<stop stop-color="#D1D1D1"/>
<stop offset="0.259865" stop-color="#F5F5F5"/>
<stop offset="0.706852" stop-color="#F4F4F4"/>
<stop offset="1" stop-color="#D2D2D2"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="1294.92" y1="1936.07" x2="1585.9" y2="1936.07" gradientUnits="userSpaceOnUse">
<stop stop-color="#848484"/>
<stop offset="0.0993312" stop-color="#DDDDDD"/>
<stop offset="0.898922" stop-color="#DDDDDD"/>
<stop offset="1" stop-color="#848484"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="1326.46" y1="1702.99" x2="1326.46" y2="1928.47" gradientUnits="userSpaceOnUse">
<stop stop-color="#8F8F8F"/>
<stop offset="0.328727" stop-color="#BDBDBD"/>
<stop offset="0.592228" stop-color="#C9C9C9"/>
<stop offset="1" stop-color="#DEDEDE"/>
</linearGradient>
<linearGradient id="paint9_linear" x1="1323.03" y1="1682.33" x2="1323.03" y2="1923.56" gradientUnits="userSpaceOnUse">
<stop stop-color="#777777"/>
<stop offset="1" stop-color="#D1D1D1"/>
</linearGradient>
<linearGradient id="paint10_linear" x1="1557.03" y1="1682.33" x2="1557.03" y2="1923.56" gradientUnits="userSpaceOnUse">
<stop stop-color="#777777"/>
<stop offset="1" stop-color="#D1D1D1"/>
</linearGradient>
<radialGradient id="paint11_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1440.41 865.462) scale(1440.41 865.462)">
<stop stop-color="#BFBFBF"/>
<stop offset="0.110766" stop-color="#BFBFBF"/>
<stop offset="0.124129" stop-color="#F5F5F5"/>
<stop offset="0.136474" stop-color="#BFBFBF"/>
<stop offset="0.365401" stop-color="#BFBFBF"/>
<stop offset="0.376459" stop-color="#E8E8E8"/>
<stop offset="0.388172" stop-color="#BFBFBF"/>
<stop offset="0.559436" stop-color="#BFBFBF"/>
<stop offset="0.614254" stop-color="#F2F2F2"/>
<stop offset="0.6392" stop-color="#BFBFBF"/>
<stop offset="0.853366" stop-color="#BFBFBF"/>
<stop offset="0.877624" stop-color="#F2F2F2"/>
<stop offset="0.908839" stop-color="#BFBFBF"/>
<stop offset="0.95123" stop-color="#BFBFBF"/>
<stop offset="1" stop-color="#BFBFBF"/>
</radialGradient>
<linearGradient id="paint12_linear" x1="1712.42" y1="-211.227" x2="1556.61" y2="836.725" gradientUnits="userSpaceOnUse">
<stop stop-color="#2C2C2C"/>
<stop offset="1" stop-color="#1B1B1B"/>
</linearGradient>
<linearGradient id="paint13_linear" x1="1440.41" y1="94.0195" x2="1440.41" y2="1615.25" gradientUnits="userSpaceOnUse">
<stop stop-color="#221D29"/>
<stop offset="1" stop-color="#293251"/>
</linearGradient>
<clipPath id="clip0">
<rect width="2880.82" height="2032" fill="white"/>
</clipPath>
<clipPath id="clip1">
<rect width="2880.82" height="2306.67" fill="white"/>
</clipPath>
<clipPath id="clip2">
<rect width="954.992" height="454.285" fill="white" transform="translate(962.916 1555.56)"/>
</clipPath>
<clipPath id="clip3">
<rect width="954.992" height="84.9711" fill="white" transform="translate(962.916 1917.41)"/>
</clipPath>
<clipPath id="clip4">
<rect width="2880.82" height="1730.92" fill="white"/>
</clipPath>
</defs>
<g clip-path="url(#clip0)">
<g clip-path="url(#clip1)">
<g clip-path="url(#clip2)">
<g filter="url(#filter0_iii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1061.98 2002.38H1001.05V2005.29H1001.05C1001.05 2005.29 1001.05 2005.29 1001.05 2005.29C1001.05 2006.66 1014.69 2007.77 1031.51 2007.77C1048.34 2007.77 1061.98 2006.66 1061.98 2005.29C1061.98 2005.29 1061.98 2005.29 1061.98 2005.29V2002.38Z" fill="url(#paint0_linear)"/>
</g>
<g filter="url(#filter1_iii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1481.03 2002.38H1400.21V2006.32C1400.21 2006.32 1400.21 2006.32 1400.21 2006.32C1400.21 2006.33 1400.21 2006.33 1400.21 2006.33V2006.53H1400.27C1401.5 2008.38 1419.09 2009.85 1440.62 2009.85C1462.15 2009.85 1479.74 2008.38 1480.96 2006.53H1481.03V2002.38Z" fill="url(#paint1_linear)"/>
</g>
<g filter="url(#filter2_iii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1878.95 2002.38H1818.02V2005.27C1818.02 2005.27 1818.02 2005.28 1818.02 2005.29C1818.02 2006.66 1831.65 2007.77 1848.48 2007.77C1865.31 2007.77 1878.95 2006.66 1878.95 2005.29C1878.95 2005.29 1878.95 2005.29 1878.95 2005.29H1878.95V2002.38Z" fill="url(#paint2_linear)"/>
</g>
<g clip-path="url(#clip3)">
<g filter="url(#filter3_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M974.336 1993.03C971.171 1991.2 963.345 1983.33 963.345 1981.67C963.345 1980.02 1917.46 1980.02 1917.46 1981.67C1917.46 1983.33 1910.44 1990.51 1906.51 1992.82C1902.59 1995.13 1881.5 2002.38 1880.48 2002.38C1879.46 2002.38 1001.33 2002.38 1000.39 2002.38C999.446 2002.38 977.5 1994.86 974.336 1993.03Z" fill="url(#paint3_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M974.336 1993.03C971.171 1991.2 963.345 1983.33 963.345 1981.67C963.345 1980.02 1917.46 1980.02 1917.46 1981.67C1917.46 1983.33 1910.44 1990.51 1906.51 1992.82C1902.59 1995.13 1881.5 2002.38 1880.48 2002.38C1879.46 2002.38 1001.33 2002.38 1000.39 2002.38C999.446 2002.38 977.5 1994.86 974.336 1993.03Z" fill="url(#paint4_linear)"/>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M963.077 1973.83C963.096 1976.67 963.085 1980.43 963.077 1980.83C962.963 1986.63 988.863 1986.63 1004.78 1986.63H1876.04C1891.96 1986.63 1918.05 1986.63 1917.79 1980.83C1917.77 1980.43 1917.84 1975.36 1917.79 1973.83C1909.47 1960.1 1891.7 1938.06 1891.7 1938.06C1888.38 1932.6 1869.12 1932.68 1865.69 1932.6C1865.69 1932.6 1589.79 1925.29 1440.41 1925.29C1291.08 1925.29 1015.14 1932.6 1015.14 1932.6C1011.71 1932.68 992.783 1932.6 989.124 1938.06C980.699 1951.97 967.864 1965.93 963.077 1973.83Z" fill="url(#paint5_linear)"/>
<g filter="url(#filter4_d)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M963.483 1972.5C959.353 1979.59 987.769 1979.59 1004.78 1979.59H1876.04C1893.06 1979.59 1921.7 1979.59 1917.34 1972.5L1891.7 1930.19C1888.38 1924.72 1869.12 1924.81 1865.69 1924.72C1865.69 1924.72 1589.79 1917.41 1440.41 1917.41C1291.08 1917.41 1015.14 1924.72 1015.14 1924.72C1011.71 1924.81 992.784 1924.72 989.125 1930.19C976.304 1951.34 963.483 1972.5 963.483 1972.5Z" fill="url(#paint6_linear)"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="963" y="1917" width="955" height="63">
<path fill-rule="evenodd" clip-rule="evenodd" d="M963.483 1972.5C959.353 1979.59 987.769 1979.59 1004.78 1979.59H1876.04C1893.06 1979.59 1921.7 1979.59 1917.34 1972.5L1891.7 1930.19C1888.38 1924.72 1869.12 1924.81 1865.69 1924.72C1865.69 1924.72 1589.79 1917.41 1440.41 1917.41C1291.08 1917.41 1015.14 1924.72 1015.14 1924.72C1011.71 1924.81 992.784 1924.72 989.125 1930.19C976.304 1951.34 963.483 1972.5 963.483 1972.5Z" fill="white"/>
</mask>
<g mask="url(#mask0)">
</g>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1440.41 1936.07C1520.76 1936.07 1585.9 1932.73 1585.9 1928.61C1585.9 1924.48 1520.76 1921.14 1440.41 1921.14C1360.06 1921.14 1294.92 1924.48 1294.92 1928.61C1294.92 1932.73 1360.06 1936.07 1440.41 1936.07ZM1440.41 1935.65C1519.16 1935.65 1583 1932.5 1583 1928.61C1583 1924.71 1519.16 1921.56 1440.41 1921.56C1361.66 1921.56 1297.83 1924.71 1297.83 1928.61C1297.83 1932.5 1361.66 1935.65 1440.41 1935.65Z" fill="url(#paint7_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1565.88 1679.69H1314.7V1927.64C1314.7 1928.1 1315.07 1928.47 1315.53 1928.47H1565.05C1565.51 1928.47 1565.88 1928.1 1565.88 1927.64V1679.69ZM1480.91 1682.18H1399.67V1779.58C1399.67 1799.5 1415.82 1815.64 1435.73 1815.64H1444.85C1464.77 1815.64 1480.91 1799.5 1480.91 1779.58V1682.18Z" fill="url(#paint8_linear)"/>
<rect x="1323.03" y="1682.33" width="0.528204" height="246.143" fill="url(#paint9_linear)"/>
<rect x="1557.02" y="1682.33" width="0.528204" height="246.143" fill="url(#paint10_linear)"/>
</g>
<g clip-path="url(#clip4)">
<g filter="url(#filter5_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M0 51.2356C0 22.9389 22.9373 0 51.233 0H2829.59C2857.88 0 2880.82 22.9421 2880.82 51.2356V1679.69C2880.82 1707.98 2857.89 1730.92 2829.59 1730.92H51.233C22.939 1730.92 0 1707.98 0 1679.69V51.2356Z" fill="url(#paint11_angular)"/>
</g>
<g filter="url(#filter6_di)">
<path d="M10.0359 51.2349V1679.69C10.0359 1702.44 28.4805 1720.89 51.233 1720.89H2829.59C2852.34 1720.89 2870.79 1702.44 2870.79 1679.69V51.2349C2870.79 28.4853 2852.34 10.0352 2829.59 10.0352H51.233C28.48 10.0352 10.0359 28.4809 10.0359 51.2349Z" fill="url(#paint12_linear)"/>
</g>
<rect x="2554.39" y="1720.89" width="2.11282" height="10.0359" fill="#3F3F3F"/>
<rect x="324.317" y="1720.89" width="2.11282" height="10.0359" fill="#3F3F3F"/>
</g>
</g>
<rect x="88.2101" y="94.0195" width="2704.4" height="1521.23" fill="url(#paint13_linear)"/>
<rect x="502" y="270.486" width="1878" height="35.5598" fill="black"/>
<path d="M2358.56 288.267L2363.33 293.037L2362.54 293.823L2357.78 289.054L2353.01 293.823L2352.22 293.037L2356.99 288.267L2352.22 283.498L2353.01 282.711L2357.78 287.48L2362.54 282.711L2363.33 283.498L2358.56 288.267Z" fill="white"/>
<path d="M2309.99 282.711V293.823H2298.88V282.711H2309.99ZM2308.88 283.823H2299.99V292.711H2308.88V283.823Z" fill="white"/>
<path d="M2256.65 287.154V288.267H2245.54V287.154H2256.65Z" fill="white"/>
<rect x="502" y="306.047" width="1878" height="1133.47" fill="#131313"/>


</g>

</svg>
''',
    frameSize: Size(2881.0, 2032.0),
    screenSize: Size(1690.0, 1020.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.windows,
      DeviceType.laptop,
      'dell-xps13',
    ),
    name: 'Dell XPS 13',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: null,
    screenPath: parseSvgPathData('M685 320.893H2739V1560.59H685V320.893Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="4024" height="2298" viewBox="0 0 4024 2298" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_d" x="1621.63" y="1708.58" width="174.651" height="58.217" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.76415"/>
<feGaussianBlur stdDeviation="0.882076"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.499066 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter1_di" x="250.005" y="0" width="2921.44" height="1846.19" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.76415"/>
<feGaussianBlur stdDeviation="0.882076"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.76415"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.49 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
</filter>
<filter id="filter2_ii" x="251.769" y="0" width="2917.91" height="1844.42" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="2.64623" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.882076"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.215686 0 0 0 0 0.215686 0 0 0 0 0.215686 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="7.93868"/>
<feGaussianBlur stdDeviation="0.882076"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.360784 0 0 0 0 0.360784 0 0 0 0 0.360784 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter3_i" x="20.6658" y="1874.41" width="3374.8" height="55.6205" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-2.64623"/>
<feGaussianBlur stdDeviation="8.82076"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter4_ii" x="19.7837" y="1857.65" width="3381.88" height="26.4623" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-2.64623"/>
<feGaussianBlur stdDeviation="0.441038"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="5.29246"/>
<feGaussianBlur stdDeviation="0.882076"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter5_i" x="1638.39" y="1858.54" width="144.66" height="12.3493" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="2.64623"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<radialGradient id="paint0_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1710.72) rotate(90) scale(1842.66 2917.91)">
<stop stop-color="#4E4E4E"/>
<stop offset="1" stop-color="#363636"/>
</radialGradient>
<radialGradient id="paint1_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(472.73 1746.07) rotate(90) scale(14.5543)">
<stop stop-color="#3F3F3F"/>
<stop offset="1" stop-color="#3F3F3F"/>
</radialGradient>
<linearGradient id="paint2_linear" x1="1623.4" y1="1708.58" x2="1623.4" y2="1763.27" gradientUnits="userSpaceOnUse">
<stop stop-color="#BDBDBD"/>
<stop offset="1" stop-color="#B4B4B4"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="1623.4" y1="1708.58" x2="1623.4" y2="1763.27" gradientUnits="userSpaceOnUse">
<stop stop-color="#BDBDBD"/>
<stop offset="1" stop-color="#B4B4B4"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="1706.72" y1="-442.991" x2="1052.3" y2="1635.34" gradientUnits="userSpaceOnUse">
<stop stop-color="#4B4B4B"/>
<stop offset="1" stop-color="#343434"/>
</linearGradient>
<radialGradient id="paint5_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1710.72) rotate(90) scale(1842.66 2917.91)">
<stop stop-color="#4E4E4E"/>
<stop offset="1" stop-color="#363636"/>
</radialGradient>
<radialGradient id="paint6_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1707.78 1925.6) rotate(43.0478) scale(1104.15 73793)">
<stop stop-color="#9B9B9B"/>
<stop offset="1" stop-color="#626262"/>
</radialGradient>
<linearGradient id="paint7_linear" x1="3011.28" y1="1938.8" x2="419.512" y2="1938.8" gradientUnits="userSpaceOnUse">
<stop stop-color="#292929"/>
<stop offset="0.630501" stop-color="#4E4E4E"/>
<stop offset="1" stop-color="#2D2D2D"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="20.6658" y1="1877.06" x2="20.6658" y2="1930.03" gradientUnits="userSpaceOnUse">
<stop stop-color="#D8D8D8"/>
<stop offset="1" stop-color="#646464"/>
</linearGradient>
<radialGradient id="paint9_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1708.06 1877.06) rotate(32.3444) scale(2101.61 38346.2)">
<stop stop-color="white" stop-opacity="0.01"/>
<stop offset="1" stop-opacity="0.5"/>
</radialGradient>
<radialGradient id="paint10_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1045.2 1908.73) rotate(90) scale(6.25647 83.8926)">
<stop stop-color="#2D2D2D"/>
<stop offset="1" stop-color="#585858"/>
</radialGradient>
<radialGradient id="paint11_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(2374.49 1908.73) rotate(90) scale(6.25647 83.8926)">
<stop stop-color="#2D2D2D"/>
<stop offset="1" stop-color="#585858"/>
</radialGradient>
<linearGradient id="paint12_linear" x1="186.734" y1="1871.05" x2="13.61" y2="1871.05" gradientUnits="userSpaceOnUse">
<stop stop-color="#414141" stop-opacity="0.01"/>
<stop offset="0.916949" stop-color="#5E5E5E"/>
<stop offset="1" stop-color="#3D3D3D" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint13_linear" x1="3406.4" y1="1871.06" x2="3229.6" y2="1871.06" gradientUnits="userSpaceOnUse">
<stop stop-color="#5D5D5D"/>
<stop offset="0.103485" stop-color="#5D5D5D"/>
<stop offset="1" stop-color="#343434" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint14_linear" x1="53.5868" y1="1870.53" x2="27.3709" y2="1870.53" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.01"/>
<stop offset="0.501676" stop-color="white"/>
<stop offset="0.771243" stop-color="white"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint15_linear" x1="3370.87" y1="1870.35" x2="3397.6" y2="1870.35" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.01"/>
<stop offset="0.539957" stop-color="white"/>
<stop offset="0.832325" stop-color="white"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</linearGradient>
<radialGradient id="paint16_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1710.72 1870.44) rotate(-77.7625) scale(1282.7 173960)">
<stop stop-color="#E4E4E4"/>
<stop offset="1" stop-color="#E4E4E4" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint17_linear" x1="1710.72" y1="52.9238" x2="1710.72" y2="1640.66" gradientUnits="userSpaceOnUse">
<stop stop-color="#221D29"/>
<stop offset="1" stop-color="#293251"/>
</linearGradient>
<clipPath id="clip0">
<rect width="3381.88" height="1944.98" fill="white" transform="translate(19.7837)"/>
</clipPath>
<clipPath id="clip1">
<rect width="2917.91" height="1868.24" fill="white" transform="translate(251.769)"/>
</clipPath>
<clipPath id="clip2">
<rect width="2917.91" height="1842.66" fill="white" transform="translate(251.769)"/>
</clipPath>
<clipPath id="clip3">
<rect width="2917.91" height="1842.66" fill="white" transform="translate(251.769)"/>
</clipPath>
<clipPath id="clip4">
<rect width="3381.88" height="113.788" fill="white" transform="translate(19.7837 1831.19)"/>
</clipPath>
<clipPath id="clip5">
<rect width="2681.51" height="19.4057" fill="white" transform="translate(367.322 1925.57)"/>
</clipPath>
<clipPath id="clip6">
<rect width="3380.12" height="53.8066" fill="white" transform="translate(20.6655 1877.06)"/>
</clipPath>
<clipPath id="clip7">
<rect width="3381.88" height="23.8161" fill="white" transform="translate(19.7837 1858.53)"/>
</clipPath>
</defs>
<g clip-path="url(#clip0)">
<g clip-path="url(#clip1)">
<rect x="256.18" y="1595.68" width="2910.85" height="272.562" rx="4.41038" fill="#1E1E1E"/>
<g clip-path="url(#clip2)">
<rect x="251.769" width="2917.91" height="1842.66" rx="48.5142" fill="url(#paint0_radial)"/>
<rect x="209.43" y="1792.38" width="3022.88" height="187.882" fill="#282828"/>
<circle cx="472.73" cy="1746.07" r="16.3184" fill="url(#paint1_radial)" stroke="#2D2D2D" stroke-width="3.5283"/>
<g filter="url(#filter0_d)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1699.14 1710.22C1698.33 1709.68 1697.51 1709.13 1696.7 1708.58C1693.29 1710.82 1689.9 1713.07 1686.5 1715.32C1680.08 1719.56 1673.66 1723.8 1667.18 1727.98C1664.84 1720.74 1659.8 1714.93 1652.7 1712.67C1647.68 1711.08 1641.47 1711.28 1635.04 1711.5C1631.16 1711.63 1627.21 1711.76 1623.4 1711.5V1760.23C1627.3 1760.05 1631.18 1760.16 1634.93 1760.27C1638.98 1760.39 1642.89 1760.5 1646.54 1760.23C1657.83 1759.4 1664.65 1752.38 1667.52 1743.05C1672.36 1746.29 1677.11 1749.61 1681.87 1752.92C1686.86 1756.41 1691.85 1759.89 1696.93 1763.27C1700.2 1761.13 1703.49 1758.94 1706.79 1756.75C1713.1 1752.55 1719.43 1748.34 1725.66 1744.46V1760.23H1757.93V1744.69C1756.02 1744.66 1754.06 1744.68 1752.11 1744.69C1748.93 1744.72 1745.75 1744.74 1742.76 1744.57V1711.5H1725.66V1728.1C1723.54 1729.48 1721.43 1730.87 1719.32 1732.26C1713.68 1735.97 1708.04 1739.68 1702.29 1743.29C1701.84 1742.99 1701.37 1742.71 1700.9 1742.43C1700.08 1741.93 1699.25 1741.44 1698.53 1740.83C1701.76 1738.69 1704.96 1736.52 1708.15 1734.34C1712.52 1731.37 1716.88 1728.41 1721.33 1725.53C1718.15 1723.06 1714.75 1720.82 1711.3 1718.63C1704.2 1723.29 1697.07 1727.91 1689.95 1732.54C1689.35 1732.93 1688.75 1733.32 1688.15 1733.71C1687.57 1733.25 1686.95 1732.83 1686.33 1732.42C1685.71 1732.01 1685.09 1731.59 1684.51 1731.14C1687.69 1729.06 1690.86 1726.96 1694.02 1724.86C1698.47 1721.91 1702.92 1718.96 1707.42 1716.06C1704.78 1714 1701.96 1712.11 1699.14 1710.22ZM1639.7 1744.69V1727.16C1639.69 1726.99 1639.68 1726.83 1639.81 1726.81C1644.75 1726.49 1648.31 1727.01 1650.42 1729.5C1653.57 1733.23 1652.85 1740.23 1649.28 1743.05C1647.11 1744.77 1644.38 1744.74 1640.87 1744.7C1640.49 1744.7 1640.1 1744.69 1639.7 1744.69Z" fill="url(#paint2_linear)"/>
<path d="M1779.47 1711.5H1762.37C1762.24 1711.52 1762.25 1711.69 1762.26 1711.85V1760.23H1794.52V1744.69H1779.47V1711.5Z" fill="url(#paint3_linear)"/>
</g>
</g>
<g clip-path="url(#clip3)">
<g filter="url(#filter1_di)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M300.282 0C273.488 0 251.769 21.7215 251.769 48.5164V1794.14C251.769 1820.94 273.489 1842.66 300.282 1842.66H3121.16C3147.96 1842.66 3169.68 1820.94 3169.68 1794.14V48.5164C3169.68 21.7139 3147.96 0 3121.16 0H300.282ZM266.765 1794.14V48.5162C266.765 30.0025 281.771 14.9951 300.282 14.9951H3121.17C3139.68 14.9951 3154.68 29.998 3154.68 48.5162V1794.14C3154.68 1812.65 3139.68 1827.66 3121.17 1827.66H300.282C281.768 1827.66 266.765 1812.66 266.765 1794.14Z" fill="url(#paint4_linear)"/>
</g>
<g filter="url(#filter2_ii)">
<rect x="251.769" width="2917.91" height="1842.66" rx="48.5142" fill="url(#paint5_radial)" fill-opacity="0.01"/>
</g>
</g>
</g>
<g clip-path="url(#clip4)">
<g clip-path="url(#clip5)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M367.322 1925.9L416.545 1944.02C417.033 1944.2 417.549 1944.29 418.069 1944.29H3008.26C3008.92 1944.29 3009.58 1944.14 3010.17 1943.86L3048.25 1925.6L367.322 1925.9Z" fill="url(#paint6_radial)"/>
<path opacity="0.4" d="M399 1937.04H3024L3009.5 1944.1H417L399 1937.04Z" fill="#2A2A2A"/>
<path opacity="0.4" d="M407.5 1940.57L3016 1941L3009.5 1944H417.5L407.5 1940.57Z" fill="url(#paint7_linear)"/>
</g>
<g clip-path="url(#clip6)">
<g filter="url(#filter3_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M3393 1880.65C3395.61 1880.67 3396.43 1883.6 3394.07 1884.7C3368.97 1896.46 3276 1930.03 3032.83 1930.03H2695.12V1929.98H700.036V1929.94H389.325C98.4194 1929.94 20.6658 1881.3 20.6658 1881.3L700.036 1877.52V1877.06H2695.12H2817.02V1877.69L3393 1880.65Z" fill="url(#paint8_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M3393 1880.65C3395.61 1880.67 3396.43 1883.6 3394.07 1884.7C3368.97 1896.46 3276 1930.03 3032.83 1930.03H2695.12V1929.98H700.036V1929.94H389.325C98.4194 1929.94 20.6658 1881.3 20.6658 1881.3L700.036 1877.52V1877.06H2695.12H2817.02V1877.69L3393 1880.65Z" fill="url(#paint9_radial)"/>
</g>
<ellipse cx="1045.2" cy="1909.26" rx="22.4929" ry="5.73349" fill="url(#paint10_radial)"/>
<ellipse cx="2374.49" cy="1909.26" rx="22.4929" ry="5.73349" fill="url(#paint11_radial)"/>
<path opacity="0.4" fill-rule="evenodd" clip-rule="evenodd" d="M219.133 1923.81C219.133 1923.81 1951.56 1923.81 2817.77 1923.81C2950.65 1923.81 3216.43 1923.81 3216.43 1923.81V1929.99H219.133V1923.81Z" fill="#D8D8D8"/>
</g>
<path d="M19.7834 1836.48C19.7834 1833.56 22.153 1831.19 25.0759 1831.19H3396.37C3399.29 1831.19 3401.66 1833.56 3401.66 1836.48V1858.54H19.7834V1836.48Z" fill="#1B1B1B"/>
<path d="M1309.38 1858.53H1325.26C1325.25 1852.2 1321.7 1847.07 1317.32 1847.07C1312.93 1847.07 1309.38 1852.2 1309.38 1858.53Z" fill="#1B1B1B"/>
<path d="M2089.13 1858.53H2105.01C2105.01 1852.2 2101.46 1847.07 2097.07 1847.07C2092.69 1847.07 2089.13 1852.2 2089.13 1858.53Z" fill="#1B1B1B"/>
<g clip-path="url(#clip7)">
<g filter="url(#filter4_ii)">
<path d="M19.7837 1878.82C19.7837 1880.77 21.3634 1882.35 23.312 1882.35H3398.14C3400.08 1882.35 3401.66 1880.77 3401.66 1878.82V1858.53H19.7837V1878.82Z" fill="#C2C2C2"/>
<path d="M19.7837 1878.82C19.7837 1880.77 21.3634 1882.35 23.312 1882.35H3398.14C3400.08 1882.35 3401.66 1880.77 3401.66 1878.82V1858.53H19.7837V1878.82Z" fill="url(#paint12_linear)"/>
<path d="M19.7837 1878.82C19.7837 1880.77 21.3634 1882.35 23.312 1882.35H3398.14C3400.08 1882.35 3401.66 1880.77 3401.66 1878.82V1858.53H19.7837V1878.82Z" fill="url(#paint13_linear)"/>
<path d="M19.7837 1878.82C19.7837 1880.77 21.3634 1882.35 23.312 1882.35H3398.14C3400.08 1882.35 3401.66 1880.77 3401.66 1878.82V1858.53H19.7837V1878.82Z" fill="url(#paint14_linear)"/>
<path d="M19.7837 1878.82C19.7837 1880.77 21.3634 1882.35 23.312 1882.35H3398.14C3400.08 1882.35 3401.66 1880.77 3401.66 1878.82V1858.53H19.7837V1878.82Z" fill="url(#paint15_linear)"/>
<path d="M19.7837 1878.82C19.7837 1880.77 21.3634 1882.35 23.312 1882.35H3398.14C3400.08 1882.35 3401.66 1880.77 3401.66 1878.82V1858.53H19.7837V1878.82Z" fill="url(#paint16_radial)"/>
</g>
<g filter="url(#filter5_i)">
<path d="M1638.39 1858.54V1864.71C1638.39 1868.12 1641.16 1870.88 1644.57 1870.88H1776.88C1780.29 1870.88 1783.05 1868.12 1783.05 1864.71V1858.54H1638.39Z" fill="#AFAFAF"/>
</g>
</g>
</g>
</g>
<g opacity="0.9">
<rect x="299.402" y="52.9238" width="2822.64" height="1587.74" fill="#FF0000"/>
<rect x="299.402" y="52.9238" width="2822.64" height="1587.74" fill="url(#paint17_linear)"/>
</g>
<rect x="685" y="282" width="2054" height="38.8923" fill="black"/>
<path d="M2715.55 301.444L2720.77 306.661L2719.91 307.521L2714.69 302.305L2709.48 307.521L2708.62 306.661L2713.83 301.444L2708.62 296.228L2709.48 295.367L2714.69 300.584L2719.91 295.367L2720.77 296.228L2715.55 301.444Z" fill="white"/>
<path d="M2662.43 295.367V307.521H2650.28V295.367H2662.43ZM2661.22 296.584H2651.49V306.304H2661.22V296.584Z" fill="white"/>
<path d="M2604.09 300.229V301.445H2591.94V300.229H2604.09Z" fill="white"/>
<rect x="685" y="320.893" width="2054" height="1239.69" fill="#131313"/>



</svg>
''',
    frameSize: Size(4024.0, 2298.0),
    screenSize: Size(1690.0, 1020.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.iOS,
      DeviceType.phone,
      'iphone-11pro',
    ),
    name: 'iPhone 11 Pro',
    pixelRatio: 3.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 44.0,
      right: 0.0,
      bottom: 34.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 44.0,
      top: 0.0,
      right: 44.0,
      bottom: 21.0,
    ),
    screenPath: parseSvgPathData(
        'M690.281 73.9842V74.7025C690.281 94.6668 675.048 119.955 640 119.955H290.909C255.861 119.955 240.629 94.6668 240.629 74.7025V73.9842C240.629 64.7506 240.629 55.3086 224.108 55.3086H154.433C96.2047 55.3086 61.0551 90.4583 61.0551 148.687V1711.69C61.0551 1769.92 96.2047 1805.07 154.433 1805.07H775.758C833.986 1805.07 869.136 1769.92 869.136 1711.69V148.687C869.136 90.4583 833.986 55.3086 775.758 55.3086H706.801C690.281 55.3086 690.281 64.7506 690.281 73.9842Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="931" height="1861" viewBox="0 0 931 1861" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_i" x="10.0562" y="4.30981" width="910.079" height="1851.76" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="2.87318"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.6 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter1_i" x="422.111" y="1857.51" width="86.6876" height="3.59147" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.718294"/>
<feGaussianBlur stdDeviation="0.718294"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.592157 0 0 0 0 0.592157 0 0 0 0 0.592157 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter2_i" x="28.7318" y="34.9478" width="72.5085" height="1788.08" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="7.90123"/>
<feGaussianBlur stdDeviation="6.1055"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.6 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter3_i" x="836.849" y="34.9478" width="72.5085" height="1788.08" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="7.90123"/>
<feGaussianBlur stdDeviation="6.1055"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.6 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter4_ii" x="0" y="249.248" width="7.90124" height="76.1392" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4.30976"/>
<feGaussianBlur stdDeviation="1.07744"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-4.30976"/>
<feGaussianBlur stdDeviation="1.07744"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter5_ii" x="0" y="380.696" width="7.90124" height="140.786" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4.30976"/>
<feGaussianBlur stdDeviation="1.07744"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-4.30976"/>
<feGaussianBlur stdDeviation="1.07744"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter6_ii" x="0" y="550.932" width="7.90124" height="140.786" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4.30976"/>
<feGaussianBlur stdDeviation="1.07744"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-4.30976"/>
<feGaussianBlur stdDeviation="1.07744"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter7_ii" x="922.29" y="425.23" width="7.90124" height="221.235" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4.30976"/>
<feGaussianBlur stdDeviation="1.07744"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-4.30976"/>
<feGaussianBlur stdDeviation="1.07744"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter8_iii" x="409.428" y="66.8013" width="112.054" height="15.0842" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="2.87318" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.43659"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.795035 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-2.87318"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.80013 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.43659"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.197067 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter9_dd" x="549.495" y="59.6183" width="28.7318" height="28.7318" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="3.59147" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.79574"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="1.43659" operator="dilate" in="SourceAlpha" result="effect2_dropShadow"/>
<feOffset/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
</filter>
<filter id="filter10_f" x="561.393" y="62.8962" width="16.4296" height="18.5845" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.95253" result="effect1_foregroundBlur"/>
</filter>
<linearGradient id="paint0_linear" x1="10.0562" y1="4.30981" x2="10.0562" y2="1856.07" gradientUnits="userSpaceOnUse">
<stop stop-color="#C9C6C8"/>
<stop offset="0.0168336" stop-color="#716D6D"/>
<stop offset="0.0782507" stop-color="#C9C6C8"/>
<stop offset="0.920557" stop-color="#C9C6C8"/>
<stop offset="0.980426" stop-color="#716D6D"/>
<stop offset="1" stop-color="#C9C6C8"/>
</linearGradient>
<linearGradient id="paint1_linear" x1="436.251" y1="13.6475" x2="436.251" y2="131.027" gradientUnits="userSpaceOnUse">
<stop stop-opacity="0.901495"/>
<stop offset="1" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="497.247" y1="1846.73" x2="497.247" y2="1717.16" gradientUnits="userSpaceOnUse">
<stop stop-opacity="0.9"/>
<stop offset="1" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="435.682" y1="20.1123" x2="435.682" y2="136.572" gradientUnits="userSpaceOnUse">
<stop stop-opacity="0.5"/>
<stop offset="1" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="497.565" y1="1838.83" x2="497.565" y2="1710.27" gradientUnits="userSpaceOnUse">
<stop stop-opacity="0.5"/>
<stop offset="1" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="19.3939" y1="13.6475" x2="19.3939" y2="1846.73" gradientUnits="userSpaceOnUse">
<stop stop-color="#5F5F5F"/>
<stop offset="0.0101238" stop-color="#222222"/>
<stop offset="1" stop-color="#252525"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="2.14768" y1="293.587" x2="4.31952" y2="293.587" gradientUnits="userSpaceOnUse">
<stop stop-color="#A5A5A5"/>
<stop offset="0.00734796" stop-color="#E2E2E2"/>
<stop offset="0.994739" stop-color="#BEBEBE"/>
<stop offset="1" stop-color="#9D9D9D"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="2.14768" y1="463" x2="4.31952" y2="463" gradientUnits="userSpaceOnUse">
<stop stop-color="#A5A5A5"/>
<stop offset="0.00734796" stop-color="#E2E2E2"/>
<stop offset="0.994739" stop-color="#BEBEBE"/>
<stop offset="1" stop-color="#9D9D9D"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="2.14768" y1="633.236" x2="4.31952" y2="633.236" gradientUnits="userSpaceOnUse">
<stop stop-color="#A5A5A5"/>
<stop offset="0.00734796" stop-color="#E2E2E2"/>
<stop offset="0.994739" stop-color="#BEBEBE"/>
<stop offset="1" stop-color="#9D9D9D"/>
</linearGradient>
<linearGradient id="paint9_linear" x1="927.461" y1="526.642" x2="927.339" y2="526.642" gradientUnits="userSpaceOnUse">
<stop stop-color="#8E8E8E"/>
<stop offset="1" stop-color="#BCBCBC"/>
</linearGradient>
<linearGradient id="paint10_linear" x1="930.191" y1="427.385" x2="930.191" y2="644.31" gradientUnits="userSpaceOnUse">
<stop stop-opacity="0.996971"/>
<stop offset="0.0951211" stop-opacity="0.01"/>
<stop offset="0.895463" stop-opacity="0.01"/>
<stop offset="1" stop-opacity="0.881058"/>
</linearGradient>
<radialGradient id="paint11_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(583.256 96.9465) rotate(45.1938) scale(27.4757)">
<stop stop-color="#434343"/>
<stop offset="1" stop-color="#121212"/>
</radialGradient>
<linearGradient id="paint12_linear" x1="563.861" y1="52.4354" x2="563.861" y2="81.1672" gradientUnits="userSpaceOnUse">
<stop stop-color="#2A4893"/>
<stop offset="1" stop-color="#213054"/>
</linearGradient>
<clipPath id="clip0">
<rect width="918.698" height="1860.38" fill="white" transform="translate(5.74634)"/>
</clipPath>
<clipPath id="clip1">
<rect width="107.744" height="2.87318" fill="white" transform="translate(411.583 1857.51)"/>
</clipPath>
<clipPath id="clip2">
<rect width="872.727" height="1788.55" fill="white" transform="translate(28.7318 34.478)"/>
</clipPath>
<clipPath id="clip3">
<rect width="930.191" height="438.159" fill="white" transform="translate(0 251.403)"/>
</clipPath>
<clipPath id="clip4">
<rect width="112.054" height="15.0842" fill="white" transform="translate(409.428 66.8013)"/>
</clipPath>
<clipPath id="clip5">
<rect width="27.2952" height="27.2952" fill="white" transform="translate(550.213 60.3367)"/>
</clipPath>
</defs>
<g clip-path="url(#clip0)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M168.799 0H761.392C875.307 0 924.444 56.3207 924.444 163.053V1697.33C924.444 1800.47 871.715 1860.38 761.392 1860.38H168.799C54.8841 1860.38 5.74634 1804.06 5.74634 1697.33V163.053C5.74634 56.3207 54.8841 0 168.799 0Z" fill="black"/>
<g filter="url(#filter0_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M168.799 4.30981C59.9665 4.30981 10.0562 55.9097 10.0562 163.053V1697.33C10.0562 1804.47 59.9665 1856.07 168.799 1856.07H761.392C866.676 1856.07 920.135 1800.83 920.135 1697.33V163.053C920.135 55.9097 870.224 4.30981 761.392 4.30981H168.799Z" fill="#C9C6C8"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M168.799 4.30981C59.9665 4.30981 10.0562 55.9097 10.0562 163.053V1697.33C10.0562 1804.47 59.9665 1856.07 168.799 1856.07H761.392C866.676 1856.07 920.135 1800.83 920.135 1697.33V163.053C920.135 55.9097 870.224 4.30981 761.392 4.30981H168.799Z" fill="url(#paint0_linear)"/>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M13.0934 117.697C25.3981 46.0027 75.4014 13.6475 168.799 13.6475H761.392C854.789 13.6475 904.792 46.0025 917.097 117.696C899.602 53.5517 850.168 20.1121 761.392 20.1121H168.799C80.023 20.1121 30.5885 53.5519 13.0934 117.697ZM12.4822 1738.94C23.6616 1813.26 73.7673 1846.73 168.799 1846.73H761.392C854.534 1846.73 907.115 1809.56 918.004 1735.02C900.9 1801.46 849.523 1838.83 761.392 1838.83H168.799C78.9661 1838.83 29.4171 1804.59 12.4822 1738.94Z" fill="url(#paint1_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M13.0934 117.697C25.3981 46.0027 75.4014 13.6475 168.799 13.6475H761.392C854.789 13.6475 904.792 46.0025 917.097 117.696C899.602 53.5517 850.168 20.1121 761.392 20.1121H168.799C80.023 20.1121 30.5885 53.5519 13.0934 117.697ZM12.4822 1738.94C23.6616 1813.26 73.7673 1846.73 168.799 1846.73H761.392C854.534 1846.73 907.115 1809.56 918.004 1735.02C900.9 1801.46 849.523 1838.83 761.392 1838.83H168.799C78.9661 1838.83 29.4171 1804.59 12.4822 1738.94Z" fill="url(#paint2_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M168.799 20.1123H761.392C875.307 20.1123 924.444 75.1718 924.444 179.514V1679.43C924.444 1780.26 871.715 1838.83 761.392 1838.83H168.799C54.8841 1838.83 5.74634 1783.77 5.74634 1679.43V179.514C5.74634 75.1718 54.8841 20.1123 168.799 20.1123Z" fill="url(#paint3_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M168.799 20.1123H761.392C875.307 20.1123 924.444 75.1718 924.444 179.514V1679.43C924.444 1780.26 871.715 1838.83 761.392 1838.83H168.799C54.8841 1838.83 5.74634 1783.77 5.74634 1679.43V179.514C5.74634 75.1718 54.8841 20.1123 168.799 20.1123Z" fill="url(#paint4_linear)"/>
<path d="M20.4714 163.053C20.4714 111.869 32.0383 74.8534 56.2262 50.6191C80.4137 26.3853 117.428 14.7249 168.799 14.7249H761.392C812.762 14.7249 849.777 26.3853 873.965 50.6191C898.152 74.8534 909.719 111.869 909.719 163.053V1697.33C909.719 1746.68 897.274 1783.71 872.625 1808.41C847.977 1833.11 810.947 1845.66 761.392 1845.66H168.799C117.428 1845.66 80.4137 1834 56.2262 1809.76C32.0383 1785.53 20.4714 1748.51 20.4714 1697.33V163.053Z" fill="url(#paint5_linear)" stroke="black" stroke-width="2.15488"/>
<path d="M168.799 36.6331C79.049 36.6331 43.0977 72.6004 43.0977 162.335V1696.61C43.0977 1786.34 79.049 1822.31 168.799 1822.31H761.392C847.551 1822.31 887.093 1782.75 887.093 1696.61V162.335C887.093 72.6004 851.142 36.6331 761.392 36.6331H168.799Z" fill="black"/>
</g>
<g clip-path="url(#clip1)">
<g filter="url(#filter1_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M425.948 1857.51C445.342 1857.51 485.403 1857.51 504.961 1857.51C505.128 1857.51 505.294 1857.51 505.458 1857.51C510.21 1857.55 509.746 1860.38 504.993 1860.38H425.916C421.163 1860.38 420.699 1857.55 425.451 1857.51C425.615 1857.51 425.781 1857.51 425.948 1857.51Z" fill="#343434"/>
</g>
</g>
<g clip-path="url(#clip2)">
<g filter="url(#filter2_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M93.3391 34.9478C48.8474 53.9893 28.7319 95.0853 28.7319 162.419V1697.72C28.7319 1761.04 49.5337 1802.61 91.8264 1823.03C91.8264 1820.76 44.5343 1789.33 44.5343 1704.91C44.5343 1664.06 44.5343 200.773 44.5343 155.094C44.5343 66.0395 93.3391 34.9478 93.3391 34.9478Z" fill="white" fill-opacity="0.599524"/>
</g>
<g filter="url(#filter3_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M836.849 34.9478C881.34 53.9893 901.456 95.0853 901.456 162.419V1697.72C901.456 1761.04 880.654 1802.61 838.361 1823.03C838.361 1820.76 885.653 1789.33 885.653 1704.91C885.653 1664.06 885.653 200.773 885.653 155.094C885.653 66.0395 836.849 34.9478 836.849 34.9478Z" fill="white" fill-opacity="0.599524"/>
</g>
</g>
<rect opacity="0.602808" x="5.74634" y="178.137" width="15.8025" height="12.9293" fill="black"/>
<rect opacity="0.602808" x="908.642" y="178.137" width="15.8025" height="12.9293" fill="black"/>
<rect opacity="0.602808" x="733.378" y="15.8025" width="15.8025" height="12.9293" transform="rotate(-90 733.378 15.8025)" fill="black"/>
<rect opacity="0.602808" x="183.883" y="1860.38" width="15.8025" height="12.9293" transform="rotate(-90 183.883 1860.38)" fill="black"/>
<rect opacity="0.602808" x="5.74634" y="1669.32" width="15.8025" height="12.9293" fill="black"/>
<rect opacity="0.602808" x="908.642" y="1669.32" width="15.8025" height="12.9293" fill="black"/>
<g clip-path="url(#clip3)">
<g filter="url(#filter4_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M5.01441 251.403C2.24503 251.403 0 253.654 0 256.431V318.204C0 320.981 2.24503 323.232 5.01441 323.232H7.87978C7.87978 319.454 7.92805 255.096 7.87978 251.403H5.01441Z" fill="url(#paint6_linear)"/>
</g>
<g filter="url(#filter5_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M5.01441 382.851C3.38405 383.252 1.42902 384.28 0.3851 385.74C0.170079 386.041 0 386.992 0 387.267C0 401.073 0 443.122 0 513.416C0 513.71 0.239392 515.193 0.385971 515.553C1.23074 517.626 2.69853 518.128 5.01441 519.326H7.87978C7.87978 515.548 7.92805 386.544 7.87978 382.851H5.01441Z" fill="url(#paint7_linear)"/>
</g>
<g filter="url(#filter6_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M5.01441 553.086C3.38405 553.488 1.42902 554.516 0.3851 555.976C0.170079 556.277 0 557.228 0 557.503C0 571.309 0 613.358 0 683.652C0 683.945 0.239392 685.429 0.385971 685.789C1.23074 687.862 2.69853 688.364 5.01441 689.562H7.87978C7.87978 685.784 7.92805 556.78 7.87978 553.086H5.01441Z" fill="url(#paint8_linear)"/>
</g>
<g filter="url(#filter7_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M925.177 427.385C926.807 427.786 928.762 428.814 929.806 430.274C930.021 430.575 930.191 431.526 930.191 431.802C930.191 445.607 930.191 568.106 930.191 638.399C930.191 638.693 929.952 640.176 929.805 640.536C928.96 642.609 927.492 643.111 925.177 644.31H922.311C922.311 640.532 922.263 431.078 922.311 427.385H925.177Z" fill="url(#paint9_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M925.177 427.385C926.807 427.786 928.762 428.814 929.806 430.274C930.021 430.575 930.191 431.526 930.191 431.802C930.191 445.607 930.191 568.106 930.191 638.399C930.191 638.693 929.952 640.176 929.805 640.536C928.96 642.609 927.492 643.111 925.177 644.31H922.311C922.311 640.532 922.263 431.078 922.311 427.385H925.177Z" fill="url(#paint10_linear)"/>
</g>
</g>
<g opacity="0.801364" clip-path="url(#clip4)">
<rect x="409.428" y="66.8013" width="112.054" height="15.0842" rx="7.54209" fill="#1D1C1C"/>
<g opacity="0.244441" filter="url(#filter8_iii)">
<rect x="409.428" y="66.8013" width="112.054" height="15.0842" rx="7.54209" fill="black" fill-opacity="0.01"/>
</g>
</g>
<g clip-path="url(#clip5)">
<circle cx="563.861" cy="73.9843" r="13.6476" fill="url(#paint11_radial)"/>
<g opacity="0.387535" filter="url(#filter9_dd)">
<circle cx="563.861" cy="73.9842" r="7.18294" fill="url(#paint12_linear)"/>
</g>
<g filter="url(#filter10_f)">
<ellipse cx="569.607" cy="72.1885" rx="4.30976" ry="5.38721" fill="#1C5894"/>
</g>
</g>



</svg>
''',
    frameSize: Size(931.0, 1861.0),
    screenSize: Size(375.0, 812.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.android,
      DeviceType.phone,
      'samsung-s8',
    ),
    name: 'Samsung Galaxy S8',
    pixelRatio: 4.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: parseSvgPathData(
        'M96.0736 103.848C56.5086 103.848 26.6562 138.699 26.6562 178.264V1673.23C26.6562 1712.8 56.5086 1747.65 96.0736 1747.65H756.926C796.491 1747.65 826.344 1712.8 826.344 1673.23V178.264C826.344 138.699 796.491 103.848 756.926 103.848H96.0736Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="853" height="1854" viewBox="0 0 853 1854" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_ii" x="0" y="312.656" width="14.4388" height="259.898" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="2.22135" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.555339"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.11068" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.896513 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter1_ii" x="0" y="676.958" width="14.4388" height="123.84" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="2.22135" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.555339"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.11068" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.896513 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter2_ii" x="838.561" y="574.22" width="14.4388" height="123.84" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="2.22135" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.555339"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.11068" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.896513 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter3_f" x="7.37593" y="4.04414" width="838.248" height="1832.3" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.754783" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter4_f" x="7.37593" y="4.04414" width="838.248" height="1832.3" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.754783" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter5_d" x="288.776" y="61.6419" width="12.2174" height="12.2174" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="0.555339" dy="0.555339"/>
<feGaussianBlur stdDeviation="0.555339"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.102129 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter6_f" x="290.043" y="63.4646" width="5.24049" height="5.79583" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.754783" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter7_d" x="245.46" y="58.8657" width="16.6602" height="16.6602" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="0.555339" dy="0.555339"/>
<feGaussianBlur stdDeviation="0.277669"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter8_i" x="171.6" y="44.9819" width="36.6523" height="36.6523" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="2.77669" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="5.55339"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.0327275 0 0 0 0 0.0327275 0 0 0 0 0.0817389 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter9_f" x="191.279" y="54.9081" width="22.5542" height="30.7648" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.50957" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter10_dd" x="166.046" y="39.4285" width="46.6484" height="46.6484" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="2.22135"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="-1.11068" dy="-1.11068"/>
<feGaussianBlur stdDeviation="2.22135"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.262745 0 0 0 0 0.443137 0 0 0 0 0.894118 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
</filter>
<filter id="filter11_i" x="570.333" y="43.8711" width="39.9844" height="39.9844" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="2.22135"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.05 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter12_f" x="582.392" y="56.9489" width="6.4251" height="9.38546" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.754783" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter13_f" x="591.252" y="62.5583" width="5.91981" height="7.05231" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.754783" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter14_f" x="650.006" y="53.9215" width="17.8068" height="21.5505" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="2.26435" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter15_f" x="658.385" y="58.3277" width="14.9321" height="17.7362" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="2.26435" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter16_f" x="653.235" y="59.2673" width="6.90641" height="10.3033" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.754783" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter17_f" x="663.08" y="65.7795" width="5.54176" height="6.71907" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.754783" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter18_f" x="653.084" y="63.0031" width="5.54176" height="6.71907" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.754783" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter19_f" x="653.084" y="63.0031" width="5.54176" height="6.71907" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.754783" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter20_iiii" x="373.188" y="56.0884" width="111.068" height="18.8815" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="2.77669" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.277669"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.776693 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.11068" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="0.555339"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.11068" operator="erode" in="SourceAlpha" result="effect3_innerShadow"/>
<feOffset dy="2.22135"/>
<feGaussianBlur stdDeviation="1.38835"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="1.11068" operator="erode" in="SourceAlpha" result="effect4_innerShadow"/>
<feOffset dy="1.11068"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.779656 0 0 0 0 0.779656 0 0 0 0 0.779656 0 0 0 0.15 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<linearGradient id="paint0_linear" x1="2.50011" y1="412.801" x2="3.05545" y2="412.801" gradientUnits="userSpaceOnUse">
<stop stop-color="#C0C0C0"/>
<stop offset="1" stop-color="#1C1C1C"/>
</linearGradient>
<linearGradient id="paint1_linear" x1="2.50011" y1="724.677" x2="3.05545" y2="724.677" gradientUnits="userSpaceOnUse">
<stop stop-color="#C0C0C0"/>
<stop offset="1" stop-color="#1C1C1C"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="2.50011" y1="47.7187" x2="3.05545" y2="47.7187" gradientUnits="userSpaceOnUse">
<stop stop-color="#C0C0C0"/>
<stop offset="1" stop-color="#1C1C1C"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="8.8855" y1="5.55371" x2="8.8855" y2="1834.84" gradientUnits="userSpaceOnUse">
<stop stop-color="#C8C8C8"/>
<stop offset="0.00362579"/>
<stop offset="0.997156"/>
<stop offset="1" stop-color="#BCBCBC"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="8.8855" y1="5.55371" x2="8.8855" y2="1834.84" gradientUnits="userSpaceOnUse">
<stop stop-color="#C8C8C8"/>
<stop offset="0.0245902"/>
<stop offset="0.0962569" stop-color="#5C5C5C"/>
<stop offset="0.915723" stop-color="#5C5C5C"/>
<stop offset="0.938902" stop-color="#D4D4D4"/>
<stop offset="0.985563"/>
<stop offset="1" stop-color="#E3E3E3"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="11.1067" y1="16.6602" x2="11.1067" y2="1821.51" gradientUnits="userSpaceOnUse">
<stop stop-color="#252525"/>
<stop offset="0.0469231" stop-color="#C9C9C9"/>
<stop offset="0.0718413" stop-color="#393939"/>
<stop offset="0.931019" stop-color="#070707"/>
<stop offset="1" stop-color="#252525"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="274.337" y1="67.1953" x2="294.329" y2="87.1875" gradientUnits="userSpaceOnUse">
<stop stop-color="#03030B"/>
<stop offset="1" stop-color="#1E2034"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="229.91" y1="66.6401" x2="253.234" y2="89.9644" gradientUnits="userSpaceOnUse">
<stop stop-color="#080819"/>
<stop offset="0.568545" stop-color="#121223"/>
<stop offset="1" stop-color="#222335"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="161.464" y1="62.7083" x2="189.606" y2="92.2736" gradientUnits="userSpaceOnUse">
<stop stop-color="#232338"/>
<stop offset="0.250148" stop-color="#232337"/>
<stop offset="0.639078" stop-color="#0C0B2C"/>
<stop offset="0.805268" stop-color="#1C264A"/>
<stop offset="1" stop-color="#8EA2C3"/>
</linearGradient>
<linearGradient id="paint9_linear" x1="119.953" y1="64.4188" x2="138.835" y2="83.3003" gradientUnits="userSpaceOnUse">
<stop stop-color="#0E0E11"/>
<stop offset="1" stop-color="#222026"/>
</linearGradient>
<linearGradient id="paint10_linear" x1="134.114" y1="69.1392" x2="143.555" y2="78.5799" gradientUnits="userSpaceOnUse">
<stop stop-color="#151516"/>
<stop offset="1" stop-color="#37353C"/>
</linearGradient>
<linearGradient id="paint11_linear" x1="568.432" y1="62.3859" x2="590.2" y2="86.9857" gradientUnits="userSpaceOnUse">
<stop stop-color="#181818"/>
<stop offset="0.733299"/>
<stop offset="1" stop-color="#585858"/>
</linearGradient>
<radialGradient id="paint12_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(590.047 54.4224) rotate(90) scale(18.3262)">
<stop stop-color="#190E22"/>
<stop offset="1"/>
</radialGradient>
<linearGradient id="paint13_linear" x1="572.5" y1="69.9409" x2="596.927" y2="81.6714" gradientUnits="userSpaceOnUse">
<stop stop-color="#D4D4D4"/>
<stop offset="0.200013" stop-color="#0A0A0A"/>
<stop offset="0.699547" stop-color="#080808"/>
<stop offset="1" stop-color="#979797"/>
</linearGradient>
<linearGradient id="paint14_linear" x1="636.022" y1="64.2407" x2="660.101" y2="88.3563" gradientUnits="userSpaceOnUse">
<stop stop-color="#24272C"/>
<stop offset="0.403886" stop-color="#29292B"/>
<stop offset="0.792142" stop-color="#272629"/>
<stop offset="1" stop-color="#94929A"/>
</linearGradient>
<linearGradient id="paint15_linear" x1="374.298" y1="57.1992" x2="374.298" y2="71.638" gradientUnits="userSpaceOnUse">
<stop stop-color="#2B2B2B"/>
<stop offset="1" stop-color="#323030"/>
</linearGradient>
<linearGradient id="paint16_linear" x1="473.438" y1="71.0274" x2="473.438" y2="57.1992" gradientUnits="userSpaceOnUse">
<stop stop-color="#1B1B1B"/>
<stop offset="1"/>
</linearGradient>
<linearGradient id="paint17_linear" x1="834.674" y1="116.853" x2="18.3262" y2="116.853" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="0.047619" stop-color="white" stop-opacity="0.01"/>
<stop offset="0.952381" stop-color="white" stop-opacity="0.01"/>
<stop offset="1" stop-color="white"/>
</linearGradient>
<clipPath id="clip0">
<rect width="853" height="1839.28" fill="white"/>
</clipPath>
<clipPath id="clip1">
<rect width="853" height="488.143" fill="white" transform="translate(0 312.656)"/>
</clipPath>
<clipPath id="clip2">
<rect width="36.6523" height="36.6523" fill="white" transform="translate(171.6 44.9819)"/>
</clipPath>
<clipPath id="clip3">
<rect width="39.9844" height="39.9844" fill="white" transform="translate(570.333 43.8711)"/>
</clipPath>
<clipPath id="clip4">
<rect width="799.688" height="1643.8" fill="white" transform="translate(26.6562 103.848)"/>
</clipPath>
</defs>
<g clip-path="url(#clip0)">
<g clip-path="url(#clip1)">
<g filter="url(#filter0_ii)">
<rect y="312.656" width="14.4388" height="259.898" rx="4.44271" fill="url(#paint0_linear)"/>
</g>
<g filter="url(#filter1_ii)">
<rect y="676.958" width="14.4388" height="123.84" rx="4.44271" fill="url(#paint1_linear)"/>
</g>
<g filter="url(#filter2_ii)">
<rect width="14.4388" height="123.84" rx="4.44271" transform="matrix(-1 0 0 1 853 574.22)" fill="url(#paint2_linear)"/>
</g>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M7.21948 155.495C7.21948 48.3175 34.9864 0 167.157 0H685.843C818.014 0 845.781 48.3145 845.781 155.495V1683.79C845.781 1790.97 818.014 1839.28 685.843 1839.28H250.591C247.461 1837.65 239.878 1836.5 231.021 1836.5C222.164 1836.5 214.581 1837.65 211.451 1839.28H167.157C34.9864 1839.28 7.21948 1790.97 7.21948 1683.79V155.495Z" fill="black"/>
<g filter="url(#filter3_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M162.664 5.55371H690.337C758.476 5.55371 792.994 16.9939 816.595 45.6811C836.351 69.6932 844.115 104.544 844.115 165.757V1680.19C844.115 1708.43 842.361 1729.41 838.431 1746.98C833.91 1767.19 826.392 1782.96 815.219 1795.41C789.343 1824.23 755.126 1834.84 679.259 1834.84H173.741C97.874 1834.84 63.6574 1824.23 37.7811 1795.41C26.6085 1782.96 19.0903 1767.19 14.5696 1746.98C10.6391 1729.41 8.8855 1708.43 8.8855 1680.19V165.757C8.8855 104.545 16.6497 69.6946 36.4047 45.6822C48.556 30.9123 61.5693 21.532 79.8208 15.3062C99.3481 8.64511 125.417 5.55371 162.664 5.55371Z" fill="url(#paint3_linear)"/>
</g>
<g filter="url(#filter4_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M690.337 5.55371H162.664C125.417 5.55371 99.3481 8.64511 79.8208 15.3062C61.5693 21.532 48.556 30.9123 36.4047 45.6822C16.6497 69.6946 8.8855 104.545 8.8855 165.757V1680.19C8.8855 1708.43 10.6391 1729.41 14.5696 1746.98C19.0903 1767.19 26.6085 1782.96 37.7811 1795.41C63.6574 1824.23 97.874 1834.84 173.741 1834.84H679.259C755.126 1834.84 789.343 1824.23 815.219 1795.41C826.392 1782.96 833.91 1767.19 838.431 1746.98C842.361 1729.41 844.115 1708.43 844.115 1680.19V165.757C844.115 104.544 836.351 69.6932 816.595 45.6811C792.994 16.9939 758.476 5.55371 690.337 5.55371ZM38.12 47.0932C60.1152 20.358 87.7245 7.77475 162.663 7.77475H690.336C760.833 7.77475 792.885 20.3574 814.88 47.092C834.624 71.0914 841.893 106.307 841.893 165.756V1680.19C841.893 1707.74 840.224 1728.79 836.263 1746.5C831.859 1766.18 824.559 1781.68 813.566 1793.92C790.023 1820.15 759.31 1832.62 679.259 1832.62H173.741C93.6896 1832.62 62.9771 1820.15 39.434 1793.92C28.4408 1781.68 21.1409 1766.18 16.7373 1746.5C12.776 1728.79 11.1067 1707.74 11.1067 1680.19V165.756C11.1067 106.309 18.3754 71.0928 38.12 47.0932Z" fill="url(#paint4_linear)"/>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M154.021 18.3262C37.3952 18.3262 12.7727 65.6809 12.7727 167.946V1671.34C12.7727 1773.6 29.0947 1819.84 162.306 1819.84H690.694C823.905 1819.84 840.227 1773.6 840.227 1671.34V167.946C840.227 65.6778 815.605 18.3262 698.979 18.3262H154.021Z" fill="black"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M698.979 16.6602H154.021C95.9515 16.6602 59.7534 28.3414 38.3878 53.7135C18.725 77.0634 11.1067 111.775 11.1067 167.946V1671.34C11.1067 1700.05 12.4247 1720.67 15.7686 1738C19.5854 1757.78 26.1245 1773.05 36.3168 1785.02C57.7869 1810.23 96.3091 1821.51 162.306 1821.51H690.694C756.691 1821.51 795.213 1810.23 816.683 1785.02C826.875 1773.05 833.414 1757.78 837.231 1738C840.575 1720.67 841.893 1700.05 841.893 1671.34V167.946C841.893 111.773 834.275 77.062 814.612 53.7123C793.247 28.3409 757.049 16.6602 698.979 16.6602ZM12.7728 167.945C12.7728 65.6807 37.3953 18.326 154.021 18.326H698.979C815.605 18.326 840.227 65.6777 840.227 167.945V1671.34C840.227 1773.6 823.905 1819.84 690.694 1819.84H162.306C29.0949 1819.84 12.7728 1773.6 12.7728 1671.34V167.945Z" fill="url(#paint5_linear)"/>
<rect opacity="0.904835" x="133.836" y="1826.51" width="1.11068" height="7.77474" fill="black"/>
<rect opacity="0.288496" x="134.947" y="1826.51" width="1.11068" height="7.77474" fill="black"/>
<rect opacity="0.904835" x="114.4" y="1825.95" width="1.11068" height="7.77474" fill="black"/>
<rect opacity="0.288496" x="115.51" y="1825.95" width="1.11068" height="7.77474" fill="black"/>
<rect opacity="0.904835" width="1.11068" height="7.77474" transform="matrix(-1 0 0 1 738.045 1827.06)" fill="black"/>
<rect opacity="0.288496" width="1.11068" height="7.77474" transform="matrix(-1 0 0 1 736.934 1827.06)" fill="black"/>
<rect opacity="0.904835" width="1.11068" height="7.77474" transform="matrix(-1 0 0 1 718.608 1826.51)" fill="black"/>
<rect opacity="0.288496" width="1.11068" height="7.77474" transform="matrix(-1 0 0 1 717.497 1826.51)" fill="black"/>
<rect opacity="0.904835" x="116.066" y="5.55322" width="1.11068" height="7.77474" fill="black"/>
<rect opacity="0.288496" x="117.176" y="5.55273" width="1.11068" height="7.77474" fill="black"/>
<rect opacity="0.904835" x="96.6289" y="8.88574" width="1.11068" height="7.77474" fill="black"/>
<rect opacity="0.288496" x="97.7395" y="8.88477" width="1.11068" height="7.77474" fill="black"/>
<rect opacity="0.904835" width="1.11068" height="7.77474" transform="matrix(-1 0 0 1 755.815 9.99707)" fill="black"/>
<rect opacity="0.288496" width="1.11068" height="7.77474" transform="matrix(-1 0 0 1 754.705 9.99609)" fill="black"/>
<rect opacity="0.904835" width="1.11068" height="7.77474" transform="matrix(-1 0 0 1 736.379 7.21973)" fill="black"/>
<rect opacity="0.288496" width="1.11068" height="7.77474" transform="matrix(-1 0 0 1 735.268 7.21924)" fill="black"/>
<circle cx="294.329" cy="67.1953" r="9.44075" fill="#13132F" stroke="url(#paint6_linear)" stroke-width="1.11068"/>
<g filter="url(#filter5_d)">
<circle cx="294.329" cy="67.1953" r="4.99805" fill="#00000C"/>
</g>
<g filter="url(#filter6_f)">
<ellipse cx="292.663" cy="66.3625" rx="1.11068" ry="1.38835" fill="white" fill-opacity="0.2"/>
</g>
<circle cx="253.234" cy="66.6401" r="11.1068" fill="#15152D" stroke="url(#paint7_linear)" stroke-width="1.11068"/>
<g filter="url(#filter7_d)">
<circle cx="253.234" cy="66.6405" r="7.77474" fill="#020315"/>
</g>
<g clip-path="url(#clip2)">
<g filter="url(#filter8_i)">
<circle cx="189.926" cy="63.3081" r="18.3262" fill="#161638"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="171" y="44" width="38" height="38">
<circle cx="189.926" cy="63.3081" r="18.3262" fill="white"/>
</mask>
<g mask="url(#mask0)">
<rect x="188.815" y="47.2036" width="2.22135" height="33.3203" fill="#252549"/>
<rect x="183.262" y="47.2036" width="2.22135" height="33.3203" fill="#252549" fill-opacity="0.75"/>
<rect x="177.708" y="47.2036" width="2.22135" height="33.3203" fill="#252549" fill-opacity="0.5"/>
<rect x="194.924" y="47.2036" width="2.22135" height="33.3203" fill="#252549" fill-opacity="0.75"/>
<rect x="199.922" y="47.2036" width="2.22135" height="33.3203" fill="#252549" fill-opacity="0.75"/>
<g filter="url(#filter9_f)">
<ellipse cx="202.557" cy="70.2903" rx="14.3885" ry="3.73302" transform="rotate(122 202.557 70.2903)" fill="#83A7FF" fill-opacity="0.5"/>
</g>
<g filter="url(#filter10_dd)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M171.6 63.3081C171.6 73.4294 179.805 81.6343 189.926 81.6343C200.047 81.6343 208.252 73.4294 208.252 63.3081C208.252 53.1868 200.047 44.9819 189.926 44.9819C179.805 44.9819 171.6 53.1868 171.6 63.3081ZM206.031 63.3082C206.031 72.2027 198.82 79.413 189.926 79.413C181.031 79.413 173.821 72.2027 173.821 63.3082C173.821 54.4138 181.031 47.2034 189.926 47.2034C198.82 47.2034 206.031 54.4138 206.031 63.3082Z" fill="url(#paint8_linear)"/>
</g>
</g>
</g>
<circle cx="138.835" cy="64.4188" r="8.88542" fill="url(#paint9_linear)" stroke="url(#paint10_linear)" stroke-width="1.11068"/>
<g clip-path="url(#clip3)">
<g filter="url(#filter11_i)">
<circle cx="590.325" cy="63.8633" r="19.9922" fill="#151517"/>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M575.886 63.8626C575.886 71.837 582.35 78.3014 590.325 78.3014C598.299 78.3014 604.764 71.837 604.764 63.8626C604.764 55.8883 598.299 49.4238 590.325 49.4238C582.35 49.4238 575.886 55.8883 575.886 63.8626ZM603.653 63.863C603.653 71.2239 597.686 77.1911 590.325 77.1911C582.964 77.1911 576.997 71.2239 576.997 63.863C576.997 56.5021 582.964 50.5348 590.325 50.5348C597.686 50.5348 603.653 56.5021 603.653 63.863Z" fill="url(#paint11_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M590.324 77.1909C597.685 77.1909 603.653 71.2237 603.653 63.8628C603.653 56.5019 597.685 50.5347 590.324 50.5347C582.964 50.5347 576.996 56.5019 576.996 63.8628C576.996 71.2237 582.964 77.1909 590.324 77.1909Z" fill="black"/>
<path d="M598.655 63.5854C598.655 68.3394 594.801 72.1932 590.047 72.1932C585.293 72.1932 581.439 68.3394 581.439 63.5854C581.439 58.8315 585.293 54.9777 590.047 54.9777C594.801 54.9777 598.655 58.8315 598.655 63.5854Z" fill="url(#paint12_radial)" stroke="url(#paint13_linear)" stroke-width="1.11068"/>
<g filter="url(#filter12_f)">
<ellipse cx="585.604" cy="61.6416" rx="1.38835" ry="3.33203" transform="rotate(19 585.604 61.6416)" fill="white" fill-opacity="0.5"/>
</g>
<g filter="url(#filter13_f)">
<ellipse cx="594.212" cy="66.0843" rx="1.11068" ry="2.22135" transform="rotate(29 594.212 66.0843)" fill="white" fill-opacity="0.5"/>
</g>
</g>
<circle cx="661.408" cy="65.5293" r="12.2174" fill="#030A1A" stroke="url(#paint14_linear)" stroke-width="2.22135"/>
<g filter="url(#filter14_f)">
<ellipse cx="658.909" cy="64.6967" rx="4.16504" ry="6.38639" transform="rotate(16 658.909 64.6967)" fill="#00236A"/>
</g>
<g filter="url(#filter15_f)">
<ellipse cx="665.851" cy="67.1956" rx="2.77669" ry="4.44271" transform="rotate(16 665.851 67.1956)" fill="#002A7E"/>
</g>
<g filter="url(#filter16_f)">
<ellipse cx="656.688" cy="64.4188" rx="1.38835" ry="3.88737" transform="rotate(22 656.688 64.4188)" fill="white" fill-opacity="0.8"/>
</g>
<g filter="url(#filter17_f)">
<ellipse cx="665.851" cy="69.1391" rx="1.11068" ry="1.94368" transform="rotate(22 665.851 69.1391)" fill="#153EB1" fill-opacity="0.8"/>
</g>
<g filter="url(#filter18_f)">
<ellipse cx="655.855" cy="66.3628" rx="1.11068" ry="1.94368" transform="rotate(22 655.855 66.3628)" fill="#153EB1" fill-opacity="0.6"/>
</g>
<g filter="url(#filter19_f)">
<ellipse cx="655.855" cy="66.3628" rx="1.11068" ry="1.94368" transform="rotate(22 655.855 66.3628)" fill="#153EB1" fill-opacity="0.6"/>
</g>
<g filter="url(#filter20_iiii)">
<rect x="374.298" y="57.1992" width="108.846" height="14.4388" rx="7.2194" fill="url(#paint15_linear)"/>
</g>
<rect x="373.743" y="56.6439" width="109.957" height="15.5495" rx="7.77474" stroke="url(#paint16_linear)" stroke-width="1.11068"/>
</g>
<g clip-path="url(#clip4)">

</g>
<path opacity="0.5" fill-rule="evenodd" clip-rule="evenodd" d="M157.367 27.2114C28.6974 27.2114 18.3262 74.0847 18.3262 172.505V1660.67C18.3262 1759.09 28.6974 1811.51 157.367 1811.51H695.633C824.303 1811.51 834.674 1759.09 834.674 1660.67V172.505C834.674 74.0817 824.303 27.2114 695.633 27.2114H157.367Z" fill="url(#paint17_linear)"/>


</svg>
''',
    frameSize: Size(853.0, 1854.0),
    screenSize: Size(360.0, 740.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.iOS,
      DeviceType.tablet,
      'ipad',
    ),
    name: 'iPad',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 20.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 20.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          67.84,
          159.0,
          1144.8,
          1526.4,
        ),
      ),
    svgFrame:
        '''<svg width="1281" height="1842" viewBox="0 0 1281 1842" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_i" x="0" y="0" width="1280.48" height="1841.57" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.353333"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter1_d" x="9.89331" y="9.89331" width="1260.69" height="1821.79" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.353333"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.557681 0 0 0 0 0.56321 0 0 0 0 0.585326 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter2_i" x="600.667" y="1727.8" width="78.44" height="77.7333" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="0.706667"/>
<feGaussianBlur stdDeviation="0.353333"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.112687 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter3_d" x="622.435" y="71.3733" width="22.024" height="22.7068" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="0.706667"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.133333 0 0 0 0 0.133333 0 0 0 0 0.133333 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter4_d" x="625.404" y="74.3361" width="16.0858" height="16.0744" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="1.41333" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.706667"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter5_f" x="627.76" y="81.3003" width="5.0015" height="5.0015" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.96046" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter6_f" x="634.139" y="77.2416" width="5.58133" height="5.58133" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.96046" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter7_f" x="628.195" y="76.633" width="7.58741" height="6.39471" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.96046" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter8_f" x="629.497" y="78.3971" width="8.00853" height="8.00853" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.96046" result="effect1_foregroundBlur"/>
</filter>
<linearGradient id="paint0_linear" x1="13.7604" y1="39.5802" x2="13.7604" y2="1841.57" gradientUnits="userSpaceOnUse">
<stop stop-color="#4C4D50" stop-opacity="0.01"/>
<stop offset="0.0362117" stop-color="#4C4D50"/>
<stop offset="0.446329" stop-color="#4C4D50" stop-opacity="0.01"/>
<stop offset="0.941095" stop-color="#4C4D50" stop-opacity="0.907892"/>
<stop offset="1" stop-color="#4C4D50" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint1_linear" x1="1280.48" y1="-1.90395" x2="0" y2="-1.90395" gradientUnits="userSpaceOnUse">
<stop stop-color="#4C4D50" stop-opacity="0.01"/>
<stop offset="0.507121" stop-color="#4C4D50" stop-opacity="0.5"/>
<stop offset="1" stop-color="#4C4D50" stop-opacity="0.01"/>
</linearGradient>
<radialGradient id="paint2_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(639.533 1766.67) scale(38.8667)">
<stop offset="0.138428" stop-color="#67666C"/>
<stop offset="0.200569" stop-color="#090A10"/>
<stop offset="0.293609" stop-color="#1D1E23"/>
<stop offset="0.321076" stop-color="#4C4B50"/>
<stop offset="0.423219" stop-color="#7F7E84"/>
<stop offset="0.501325" stop-color="#B5B5B5"/>
<stop offset="0.524768" stop-color="#090A10"/>
<stop offset="0.71246" stop-color="#151419"/>
<stop offset="0.726278" stop-color="#4D4C51"/>
<stop offset="0.769684" stop-color="#504F54"/>
<stop offset="0.777708" stop-color="#3A393E"/>
<stop offset="0.879251" stop-color="#151519"/>
<stop offset="0.926482" stop-color="#100F14"/>
<stop offset="0.950315" stop-color="#5B5C62"/>
</radialGradient>
<radialGradient id="paint3_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(649.096 100.881) rotate(45.1627) scale(22.1576 22.1577)">
<stop stop-color="white"/>
<stop offset="1" stop-color="#252525"/>
</radialGradient>
<linearGradient id="paint4_linear" x1="633.447" y1="66.7416" x2="633.447" y2="87.5838" gradientUnits="userSpaceOnUse">
<stop stop-color="#2A4893"/>
<stop offset="1" stop-color="#213054"/>
</linearGradient>
</defs>
<g filter="url(#filter0_i)">
<path d="M89.4138 0H1191.07C1217.65 0 1230.3 2.44148 1243.43 9.46444C1255.29 15.8106 1264.67 25.1866 1271.02 37.0528C1278.04 50.1846 1280.48 62.8276 1280.48 89.4138V1752.16C1280.48 1778.75 1278.04 1791.39 1271.02 1804.52C1264.67 1816.39 1255.29 1825.76 1243.43 1832.11C1230.3 1839.13 1217.65 1841.57 1191.07 1841.57H89.4138C62.8276 1841.57 50.1846 1839.13 37.0528 1832.11C25.1866 1825.76 15.8106 1816.39 9.46444 1804.52C2.44148 1791.39 0 1778.75 0 1752.16V89.4138C0 62.8276 2.44148 50.1846 9.46444 37.0528C15.8106 25.1866 25.1866 15.8106 37.0528 9.46444C50.1846 2.44148 62.8276 0 89.4138 0Z" fill="#9FA0A7"/>
<path d="M89.4138 0H1191.07C1217.65 0 1230.3 2.44148 1243.43 9.46444C1255.29 15.8106 1264.67 25.1866 1271.02 37.0528C1278.04 50.1846 1280.48 62.8276 1280.48 89.4138V1752.16C1280.48 1778.75 1278.04 1791.39 1271.02 1804.52C1264.67 1816.39 1255.29 1825.76 1243.43 1832.11C1230.3 1839.13 1217.65 1841.57 1191.07 1841.57H89.4138C62.8276 1841.57 50.1846 1839.13 37.0528 1832.11C25.1866 1825.76 15.8106 1816.39 9.46444 1804.52C2.44148 1791.39 0 1778.75 0 1752.16V89.4138C0 62.8276 2.44148 50.1846 9.46444 37.0528C15.8106 25.1866 25.1866 15.8106 37.0528 9.46444C50.1846 2.44148 62.8276 0 89.4138 0Z" fill="url(#paint0_linear)"/>
<path d="M89.4138 0H1191.07C1217.65 0 1230.3 2.44148 1243.43 9.46444C1255.29 15.8106 1264.67 25.1866 1271.02 37.0528C1278.04 50.1846 1280.48 62.8276 1280.48 89.4138V1752.16C1280.48 1778.75 1278.04 1791.39 1271.02 1804.52C1264.67 1816.39 1255.29 1825.76 1243.43 1832.11C1230.3 1839.13 1217.65 1841.57 1191.07 1841.57H89.4138C62.8276 1841.57 50.1846 1839.13 37.0528 1832.11C25.1866 1825.76 15.8106 1816.39 9.46444 1804.52C2.44148 1791.39 0 1778.75 0 1752.16V89.4138C0 62.8276 2.44148 50.1846 9.46444 37.0528C15.8106 25.1866 25.1866 15.8106 37.0528 9.46444C50.1846 2.44148 62.8276 0 89.4138 0Z" fill="url(#paint1_linear)"/>
</g>
<g filter="url(#filter1_d)">
<path d="M89.4138 10.6C62.0085 10.6 52.0707 13.4534 42.0517 18.8116C32.0328 24.1698 24.1698 32.0328 18.8116 42.0517C13.4534 52.0707 10.6 62.0085 10.6 89.4138V1752.16C10.6 1779.56 13.4534 1789.5 18.8116 1799.52C24.1698 1809.54 32.0328 1817.4 42.0517 1822.76C52.0707 1828.12 62.0085 1830.97 89.4138 1830.97H1191.07C1218.47 1830.97 1228.41 1828.12 1238.43 1822.76C1248.45 1817.4 1256.31 1809.54 1261.67 1799.52C1267.03 1789.5 1269.88 1779.56 1269.88 1752.16V89.4138C1269.88 62.0085 1267.03 52.0707 1261.67 42.0517C1256.31 32.0328 1248.45 24.1698 1238.43 18.8116C1228.41 13.4534 1218.47 10.6 1191.07 10.6H89.4138Z" fill="#0F0F0F"/>
</g>
<g filter="url(#filter2_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M639.533 1805.53C660.999 1805.53 678.4 1788.13 678.4 1766.67C678.4 1745.2 660.999 1727.8 639.533 1727.8C618.068 1727.8 600.667 1745.2 600.667 1766.67C600.667 1788.13 618.068 1805.53 639.533 1805.53ZM639.533 1801.38C658.706 1801.38 674.248 1785.84 674.248 1766.67C674.248 1747.49 658.706 1731.95 639.533 1731.95C620.361 1731.95 604.818 1747.49 604.818 1766.67C604.818 1785.84 620.361 1801.38 639.533 1801.38Z" fill="url(#paint2_angular)"/>
</g>
<g filter="url(#filter3_d)">
<ellipse cx="633.447" cy="82.3733" rx="11.012" ry="11.0001" fill="url(#paint3_radial)"/>
</g>
<g filter="url(#filter4_d)">
<ellipse cx="633.447" cy="82.3733" rx="5.21621" ry="5.21055" fill="url(#paint4_linear)"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="628" y="77" width="11" height="11">
<ellipse cx="633.447" cy="82.3733" rx="5.21621" ry="5.21055" fill="white"/>
</mask>
<g mask="url(#mask0)">
<g filter="url(#filter5_f)">
<circle cx="630.261" cy="83.801" r="0.579829" fill="#BEE5FF"/>
</g>
<g filter="url(#filter6_f)">
<circle cx="636.929" cy="80.0322" r="0.869744" fill="#75C8FF"/>
</g>
<g filter="url(#filter7_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M632.422 80.6111C633.428 80.0534 634.05 79.2518 633.811 78.8206C633.572 78.3895 632.562 78.492 631.556 79.0497C630.55 79.6074 629.928 80.409 630.167 80.8402C630.406 81.2713 631.416 81.1688 632.422 80.6111Z" fill="#3358B6"/>
</g>
<g filter="url(#filter8_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M634.075 84.4035C635.181 84.0864 635.82 82.933 635.503 81.8272C635.186 80.7215 634.033 80.0821 632.927 80.3992C631.821 80.7163 631.182 81.8697 631.499 82.9754C631.816 84.0812 632.969 84.7205 634.075 84.4035Z" fill="#00154F"/>
</g>
</g>
<rect x="63.6" y="154.76" width="1153.28" height="1534.88" rx="4.24" fill="#212121"/>



</svg>
''',
    frameSize: Size(1281.0, 1842.0),
    screenSize: Size(768.0, 1024.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.linux,
      DeviceType.desktop,
      'screen',
    ),
    name: 'Linux Screen',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: null,
    screenPath: parseSvgPathData(
        'M502 306.047H2380V1429.51C2380 1435.04 2375.52 1439.51 2370 1439.51H512C506.477 1439.51 502 1435.04 502 1429.51V306.047Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="2881" height="2032" viewBox="0 0 2881 2032" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_iii" x="1001.05" y="2001.97" width="60.9305" height="6.21891" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="1.03623"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.231686 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="0.62174"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.613026 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.24348"/>
<feGaussianBlur stdDeviation="0.207247"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.449643 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter1_iii" x="1400.21" y="2001.97" width="80.8262" height="8.29137" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="1.03623"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.231686 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="0.62174"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.613026 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.24348"/>
<feGaussianBlur stdDeviation="0.207247"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.449643 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter2_iii" x="1818.02" y="2001.97" width="60.9316" height="6.21891" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="1.03623"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.231686 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.414493"/>
<feGaussianBlur stdDeviation="0.62174"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.613026 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.24348"/>
<feGaussianBlur stdDeviation="0.207247"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.449643 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter3_ii" x="960.858" y="1980.43" width="959.093" height="21.9531" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="4.14493"/>
<feGaussianBlur stdDeviation="1.24348"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.502293 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-4.14493"/>
<feGaussianBlur stdDeviation="1.24348"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.502293 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter4_d" x="962.663" y="1917.41" width="955.539" height="63.832" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="1.24348"/>
<feGaussianBlur stdDeviation="0.207247"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.101591 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter5_i" x="0" y="0" width="2880.82" height="1730.92" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.528204"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.253255 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter6_di" x="9.50768" y="9.50695" width="2861.81" height="1711.91" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.264102"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.247934 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.264102"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.386634 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
</filter>
<linearGradient id="paint0_linear" x1="1061.98" y1="1999.69" x2="1001.05" y2="1999.69" gradientUnits="userSpaceOnUse">
<stop stop-color="#1D1D1D"/>
<stop offset="0.173469" stop-color="#363636"/>
<stop offset="0.306202" stop-color="#242424"/>
<stop offset="0.575627" stop-color="#474747"/>
<stop offset="1"/>
</linearGradient>
<linearGradient id="paint1_linear" x1="1481.03" y1="1998.65" x2="1400.21" y2="1998.65" gradientUnits="userSpaceOnUse">
<stop stop-color="#1D1D1D"/>
<stop offset="0.173469" stop-color="#363636"/>
<stop offset="0.306202" stop-color="#242424"/>
<stop offset="0.575627" stop-color="#474747"/>
<stop offset="1"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="1878.95" y1="1999.69" x2="1818.02" y2="1999.69" gradientUnits="userSpaceOnUse">
<stop stop-color="#1D1D1D"/>
<stop offset="0.173469" stop-color="#363636"/>
<stop offset="0.306202" stop-color="#242424"/>
<stop offset="0.575627" stop-color="#474747"/>
<stop offset="1"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="989.967" y1="2002.08" x2="1917.46" y2="2002.08" gradientUnits="userSpaceOnUse">
<stop stop-color="#2A2A2A"/>
<stop offset="0.498645" stop-color="#393939"/>
<stop offset="1" stop-color="#2C2C2C"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="1201.88" y1="1991.41" x2="1201.88" y2="2002.38" gradientUnits="userSpaceOnUse">
<stop stop-opacity="0.01"/>
<stop offset="1" stop-opacity="0.37316"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="1917.8" y1="1932.49" x2="963.077" y2="1932.49" gradientUnits="userSpaceOnUse">
<stop stop-color="#494949"/>
<stop offset="0.00548826" stop-color="#E4E4E4"/>
<stop offset="0.0146788" stop-color="white"/>
<stop offset="0.0262518" stop-color="#ECECEC"/>
<stop offset="0.035185" stop-color="#9C9C9C"/>
<stop offset="0.0428973" stop-color="#6C6B6B"/>
<stop offset="0.0502683" stop-color="#6E6E6E"/>
<stop offset="0.0606556" stop-color="#868686"/>
<stop offset="0.0960526" stop-color="#E2E2E2"/>
<stop offset="0.907582" stop-color="#E2E2E2"/>
<stop offset="0.941267" stop-color="#858585"/>
<stop offset="0.959083" stop-color="#777777"/>
<stop offset="0.97214" stop-color="#CBCBCB"/>
<stop offset="0.98448" stop-color="white"/>
<stop offset="0.993451" stop-color="#E4E4E4"/>
<stop offset="1" stop-color="#1C1C1C"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="1955.7" y1="1922.35" x2="1569.48" y2="1451.3" gradientUnits="userSpaceOnUse">
<stop stop-color="#D1D1D1"/>
<stop offset="0.259865" stop-color="#F5F5F5"/>
<stop offset="0.706852" stop-color="#F4F4F4"/>
<stop offset="1" stop-color="#D2D2D2"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="1294.92" y1="1936.07" x2="1585.9" y2="1936.07" gradientUnits="userSpaceOnUse">
<stop stop-color="#848484"/>
<stop offset="0.0993312" stop-color="#DDDDDD"/>
<stop offset="0.898922" stop-color="#DDDDDD"/>
<stop offset="1" stop-color="#848484"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="1326.46" y1="1702.99" x2="1326.46" y2="1928.47" gradientUnits="userSpaceOnUse">
<stop stop-color="#8F8F8F"/>
<stop offset="0.328727" stop-color="#BDBDBD"/>
<stop offset="0.592228" stop-color="#C9C9C9"/>
<stop offset="1" stop-color="#DEDEDE"/>
</linearGradient>
<linearGradient id="paint9_linear" x1="1323.03" y1="1682.33" x2="1323.03" y2="1923.56" gradientUnits="userSpaceOnUse">
<stop stop-color="#777777"/>
<stop offset="1" stop-color="#D1D1D1"/>
</linearGradient>
<linearGradient id="paint10_linear" x1="1557.03" y1="1682.33" x2="1557.03" y2="1923.56" gradientUnits="userSpaceOnUse">
<stop stop-color="#777777"/>
<stop offset="1" stop-color="#D1D1D1"/>
</linearGradient>
<radialGradient id="paint11_angular" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1440.41 865.462) scale(1440.41 865.462)">
<stop stop-color="#BFBFBF"/>
<stop offset="0.110766" stop-color="#BFBFBF"/>
<stop offset="0.124129" stop-color="#F5F5F5"/>
<stop offset="0.136474" stop-color="#BFBFBF"/>
<stop offset="0.365401" stop-color="#BFBFBF"/>
<stop offset="0.376459" stop-color="#E8E8E8"/>
<stop offset="0.388172" stop-color="#BFBFBF"/>
<stop offset="0.559436" stop-color="#BFBFBF"/>
<stop offset="0.614254" stop-color="#F2F2F2"/>
<stop offset="0.6392" stop-color="#BFBFBF"/>
<stop offset="0.853366" stop-color="#BFBFBF"/>
<stop offset="0.877624" stop-color="#F2F2F2"/>
<stop offset="0.908839" stop-color="#BFBFBF"/>
<stop offset="0.95123" stop-color="#BFBFBF"/>
<stop offset="1" stop-color="#BFBFBF"/>
</radialGradient>
<linearGradient id="paint12_linear" x1="1712.42" y1="-211.227" x2="1556.61" y2="836.725" gradientUnits="userSpaceOnUse">
<stop stop-color="#2C2C2C"/>
<stop offset="1" stop-color="#1B1B1B"/>
</linearGradient>
<linearGradient id="paint13_linear" x1="1440.41" y1="94.0195" x2="1440.41" y2="1615.25" gradientUnits="userSpaceOnUse">
<stop stop-color="#AB292C"/>
<stop offset="0.713542" stop-color="#540856"/>
<stop offset="1" stop-color="#340432"/>
</linearGradient>
<clipPath id="clip0">
<rect width="2880.82" height="2032" fill="white"/>
</clipPath>
<clipPath id="clip1">
<rect width="2880.82" height="2306.67" fill="white"/>
</clipPath>
<clipPath id="clip2">
<rect width="954.992" height="454.285" fill="white" transform="translate(962.916 1555.56)"/>
</clipPath>
<clipPath id="clip3">
<rect width="954.992" height="84.9711" fill="white" transform="translate(962.916 1917.41)"/>
</clipPath>
<clipPath id="clip4">
<rect width="2880.82" height="1730.92" fill="white"/>
</clipPath>
</defs>
<g clip-path="url(#clip0)">
<g clip-path="url(#clip1)">
<g clip-path="url(#clip2)">
<g filter="url(#filter0_iii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1061.98 2002.38H1001.05V2005.29H1001.05C1001.05 2005.29 1001.05 2005.29 1001.05 2005.29C1001.05 2006.66 1014.69 2007.77 1031.51 2007.77C1048.34 2007.77 1061.98 2006.66 1061.98 2005.29C1061.98 2005.29 1061.98 2005.29 1061.98 2005.29V2002.38Z" fill="url(#paint0_linear)"/>
</g>
<g filter="url(#filter1_iii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1481.03 2002.38H1400.21V2006.32C1400.21 2006.32 1400.21 2006.32 1400.21 2006.32C1400.21 2006.33 1400.21 2006.33 1400.21 2006.33V2006.53H1400.27C1401.5 2008.38 1419.09 2009.85 1440.62 2009.85C1462.15 2009.85 1479.74 2008.38 1480.96 2006.53H1481.03V2002.38Z" fill="url(#paint1_linear)"/>
</g>
<g filter="url(#filter2_iii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1878.95 2002.38H1818.02V2005.27C1818.02 2005.27 1818.02 2005.28 1818.02 2005.29C1818.02 2006.66 1831.65 2007.77 1848.48 2007.77C1865.31 2007.77 1878.95 2006.66 1878.95 2005.29C1878.95 2005.29 1878.95 2005.29 1878.95 2005.29H1878.95V2002.38Z" fill="url(#paint2_linear)"/>
</g>
<g clip-path="url(#clip3)">
<g filter="url(#filter3_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M974.336 1993.03C971.171 1991.2 963.345 1983.33 963.345 1981.67C963.345 1980.02 1917.46 1980.02 1917.46 1981.67C1917.46 1983.33 1910.44 1990.51 1906.51 1992.82C1902.59 1995.13 1881.5 2002.38 1880.48 2002.38C1879.46 2002.38 1001.33 2002.38 1000.39 2002.38C999.446 2002.38 977.5 1994.86 974.336 1993.03Z" fill="url(#paint3_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M974.336 1993.03C971.171 1991.2 963.345 1983.33 963.345 1981.67C963.345 1980.02 1917.46 1980.02 1917.46 1981.67C1917.46 1983.33 1910.44 1990.51 1906.51 1992.82C1902.59 1995.13 1881.5 2002.38 1880.48 2002.38C1879.46 2002.38 1001.33 2002.38 1000.39 2002.38C999.446 2002.38 977.5 1994.86 974.336 1993.03Z" fill="url(#paint4_linear)"/>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M963.077 1973.83C963.096 1976.67 963.085 1980.43 963.077 1980.83C962.963 1986.63 988.863 1986.63 1004.78 1986.63H1876.04C1891.96 1986.63 1918.05 1986.63 1917.79 1980.83C1917.77 1980.43 1917.84 1975.36 1917.79 1973.83C1909.47 1960.1 1891.7 1938.06 1891.7 1938.06C1888.38 1932.6 1869.12 1932.68 1865.69 1932.6C1865.69 1932.6 1589.79 1925.29 1440.41 1925.29C1291.08 1925.29 1015.14 1932.6 1015.14 1932.6C1011.71 1932.68 992.783 1932.6 989.124 1938.06C980.699 1951.97 967.864 1965.93 963.077 1973.83Z" fill="url(#paint5_linear)"/>
<g filter="url(#filter4_d)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M963.483 1972.5C959.353 1979.59 987.769 1979.59 1004.78 1979.59H1876.04C1893.06 1979.59 1921.7 1979.59 1917.34 1972.5L1891.7 1930.19C1888.38 1924.72 1869.12 1924.81 1865.69 1924.72C1865.69 1924.72 1589.79 1917.41 1440.41 1917.41C1291.08 1917.41 1015.14 1924.72 1015.14 1924.72C1011.71 1924.81 992.784 1924.72 989.125 1930.19C976.304 1951.34 963.483 1972.5 963.483 1972.5Z" fill="url(#paint6_linear)"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="963" y="1917" width="955" height="63">
<path fill-rule="evenodd" clip-rule="evenodd" d="M963.483 1972.5C959.353 1979.59 987.769 1979.59 1004.78 1979.59H1876.04C1893.06 1979.59 1921.7 1979.59 1917.34 1972.5L1891.7 1930.19C1888.38 1924.72 1869.12 1924.81 1865.69 1924.72C1865.69 1924.72 1589.79 1917.41 1440.41 1917.41C1291.08 1917.41 1015.14 1924.72 1015.14 1924.72C1011.71 1924.81 992.784 1924.72 989.125 1930.19C976.304 1951.34 963.483 1972.5 963.483 1972.5Z" fill="white"/>
</mask>
<g mask="url(#mask0)">
</g>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1440.41 1936.07C1520.76 1936.07 1585.9 1932.73 1585.9 1928.61C1585.9 1924.48 1520.76 1921.14 1440.41 1921.14C1360.06 1921.14 1294.92 1924.48 1294.92 1928.61C1294.92 1932.73 1360.06 1936.07 1440.41 1936.07ZM1440.41 1935.65C1519.16 1935.65 1583 1932.5 1583 1928.61C1583 1924.71 1519.16 1921.56 1440.41 1921.56C1361.66 1921.56 1297.83 1924.71 1297.83 1928.61C1297.83 1932.5 1361.66 1935.65 1440.41 1935.65Z" fill="url(#paint7_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1565.88 1679.69H1314.7V1927.64C1314.7 1928.1 1315.07 1928.47 1315.53 1928.47H1565.05C1565.51 1928.47 1565.88 1928.1 1565.88 1927.64V1679.69ZM1480.91 1682.18H1399.67V1779.58C1399.67 1799.5 1415.82 1815.64 1435.73 1815.64H1444.85C1464.77 1815.64 1480.91 1799.5 1480.91 1779.58V1682.18Z" fill="url(#paint8_linear)"/>
<rect x="1323.03" y="1682.33" width="0.528204" height="246.143" fill="url(#paint9_linear)"/>
<rect x="1557.02" y="1682.33" width="0.528204" height="246.143" fill="url(#paint10_linear)"/>
</g>
<g clip-path="url(#clip4)">
<g filter="url(#filter5_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M0 51.2356C0 22.9389 22.9373 0 51.233 0H2829.59C2857.88 0 2880.82 22.9421 2880.82 51.2356V1679.69C2880.82 1707.98 2857.89 1730.92 2829.59 1730.92H51.233C22.939 1730.92 0 1707.98 0 1679.69V51.2356Z" fill="url(#paint11_angular)"/>
</g>
<g filter="url(#filter6_di)">
<path d="M10.0359 51.2349V1679.69C10.0359 1702.44 28.4805 1720.89 51.233 1720.89H2829.59C2852.34 1720.89 2870.79 1702.44 2870.79 1679.69V51.2349C2870.79 28.4853 2852.34 10.0352 2829.59 10.0352H51.233C28.48 10.0352 10.0359 28.4809 10.0359 51.2349Z" fill="url(#paint12_linear)"/>
</g>
<rect x="2554.39" y="1720.89" width="2.11282" height="10.0359" fill="#3F3F3F"/>
<rect x="324.317" y="1720.89" width="2.11282" height="10.0359" fill="#3F3F3F"/>
</g>
</g>
<rect x="88.2101" y="94.0195" width="2704.4" height="1521.23" fill="url(#paint13_linear)"/>
<path d="M502 280.486C502 274.963 506.477 270.486 512 270.486H2370C2375.52 270.486 2380 274.963 2380 280.486V306.046H502V280.486Z" fill="#333031"/>
<circle cx="2357.5" cy="288.5" r="11.5" fill="#DF5724"/>
<path d="M2357.97 288.266L2361.98 292.278L2361.32 292.94L2357.3 288.927L2353.29 292.94L2352.63 292.278L2356.64 288.266L2352.63 284.254L2353.29 283.592L2357.3 287.604L2361.32 283.592L2361.98 284.254L2357.97 288.266Z" fill="white"/>
<path d="M2323.11 283.592V292.94H2313.76V283.592H2323.11ZM2322.17 284.527H2314.7V292.004H2322.17V284.527Z" fill="white"/>
<path d="M2281.24 287.332V288.268H2271.89V287.332H2281.24Z" fill="white"/>
<path d="M502 306.047H2380V1429.51C2380 1435.04 2375.52 1439.51 2370 1439.51H512C506.477 1439.51 502 1435.04 502 1429.51V306.047Z" fill="#131313"/>


</g>

</svg>
''',
    frameSize: Size(2881.0, 2032.0),
    screenSize: Size(1690.0, 1020.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.iOS,
      DeviceType.phone,
      'iphone-6-5-inch',
    ),
    name: 'iPhone 6.5"',
    pixelRatio: 3.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          0.0,
          0.0,
          414.0,
          896.0,
        ),
      ),
    svgFrame:
        '''<svg width="414" height="896" viewBox="0 0 414 896" fill="none" xmlns="http://www.w3.org/2000/svg">
	<!-- SCREEN SHAPE -->
	
	<!-- DEVICE PROPERTIES -->
	
</svg>
''',
    frameSize: Size(414.0, 896.0),
    screenSize: Size(414.0, 896.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.iOS,
      DeviceType.tablet,
      'ipad-pro12-9',
    ),
    name: 'iPad Pro (12.9-inch)',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 20.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 24.0,
      right: 0.0,
      bottom: 20.0,
    ),
    screenPath: parseSvgPathData(
        'M60.7473 98.9674C60.7473 86.9181 60.7473 80.8934 63.0923 76.2911C65.155 72.2429 68.4463 68.9516 72.4945 66.8889C77.0967 64.5439 83.1214 64.5439 95.1707 64.5439H1322.26C1334.31 64.5439 1340.34 64.5439 1344.94 66.8889C1348.99 68.9516 1352.28 72.2429 1354.34 76.2911C1356.69 80.8934 1356.69 86.918 1356.69 98.9674V1758.89C1356.69 1770.93 1356.69 1776.96 1354.34 1781.56C1352.28 1785.61 1348.99 1788.9 1344.94 1790.96C1340.34 1793.31 1334.31 1793.31 1322.26 1793.31H95.1708C83.1214 1793.31 77.0967 1793.31 72.4945 1790.96C68.4463 1788.9 65.155 1785.61 63.0923 1781.56C60.7473 1776.96 60.7473 1770.93 60.7473 1758.89V98.9674Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="1471" height="1855" viewBox="0 0 1471 1855" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_i" x="1254.18" y="0" width="78.4652" height="5.69505" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.26557"/>
<feGaussianBlur stdDeviation="0.316392"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.407843 0 0 0 0 0.411765 0 0 0 0 0.427451 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter1_i" x="1415.54" y="132.252" width="5.06227" height="67.0751" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.26557"/>
<feGaussianBlur stdDeviation="0.316392"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.396078 0 0 0 0 0.4 0 0 0 0 0.423529 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter2_i" x="1415.54" y="211.35" width="5.06227" height="67.0751" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.26557"/>
<feGaussianBlur stdDeviation="0.316392"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.396078 0 0 0 0 0.4 0 0 0 0 0.423529 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter3_ii" x="0" y="3.79675" width="1417.44" height="1850.26" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.316392"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.649346 0 0 0 0 0.664612 0 0 0 0 0.691327 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.316392"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.418509 0 0 0 0 0.422775 0 0 0 0 0.439838 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter4_dd" x="703.023" y="23.4131" width="19.6163" height="19.6163" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="2.53113" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.26557"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="1.26557" operator="dilate" in="SourceAlpha" result="effect2_dropShadow"/>
<feOffset/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
</filter>
<filter id="filter5_f" x="704.874" y="26.1997" width="8.33921" height="12.7973" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.29006" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter6_f" x="710.567" y="25.8952" width="10.8553" height="12.1209" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.29006" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter7_f" x="707.479" y="31.8781" width="12.0004" height="9.73212" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="0.968556" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter8_i" x="1417.44" y="408.145" width="53.7866" height="1093.9" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="0.632784" dy="-0.632784"/>
<feGaussianBlur stdDeviation="2.84753"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.301913 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<linearGradient id="paint0_linear" x1="1254.18" y1="5.06227" x2="1332.64" y2="5.06227" gradientUnits="userSpaceOnUse">
<stop stop-color="#9E9E9E"/>
<stop offset="0.0278123" stop-color="#717173"/>
<stop offset="0.0507576" stop-color="#77787C"/>
<stop offset="0.0664693" stop-color="#909192"/>
<stop offset="0.102677" stop-color="#A1A5AC"/>
<stop offset="0.886742" stop-color="#A1A5AC"/>
<stop offset="0.917669" stop-color="#ACADAF"/>
<stop offset="0.94449" stop-color="#6B6C6E"/>
<stop offset="0.96308" stop-color="#656668"/>
<stop offset="1" stop-color="#AFAFAF"/>
</linearGradient>
<linearGradient id="paint1_linear" x1="1423.03" y1="137.221" x2="1487.04" y2="137.221" gradientUnits="userSpaceOnUse">
<stop stop-color="#9C9C9C"/>
<stop offset="0.0247813" stop-color="#717173"/>
<stop offset="0.0462707" stop-color="#595B5F"/>
<stop offset="0.0585311" stop-color="#909192"/>
<stop offset="0.0869519" stop-color="#A1A5AC"/>
<stop offset="0.886742" stop-color="#A1A5AC"/>
<stop offset="0.917669" stop-color="#ACADAF"/>
<stop offset="0.94449" stop-color="#6B6C6E"/>
<stop offset="0.96308" stop-color="#656668"/>
<stop offset="1" stop-color="#959595"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="1423.03" y1="216.319" x2="1487.04" y2="216.319" gradientUnits="userSpaceOnUse">
<stop stop-color="#9C9C9C"/>
<stop offset="0.0247813" stop-color="#717173"/>
<stop offset="0.0462707" stop-color="#595B5F"/>
<stop offset="0.0585311" stop-color="#909192"/>
<stop offset="0.0869519" stop-color="#A1A5AC"/>
<stop offset="0.886742" stop-color="#A1A5AC"/>
<stop offset="0.917669" stop-color="#ACADAF"/>
<stop offset="0.94449" stop-color="#6B6C6E"/>
<stop offset="0.96308" stop-color="#656668"/>
<stop offset="1" stop-color="#959595"/>
</linearGradient>
<radialGradient id="paint3_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(724.072 46.5296) rotate(45.1938) scale(15.9242)">
<stop stop-color="#434343"/>
<stop offset="1" stop-color="#121212"/>
</radialGradient>
<linearGradient id="paint4_linear" x1="712.831" y1="18.9836" x2="712.831" y2="37.9671" gradientUnits="userSpaceOnUse">
<stop stop-color="#2A4893"/>
<stop offset="1" stop-color="#213054"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="1419.25" y1="427.49" x2="1470.59" y2="427.49" gradientUnits="userSpaceOnUse">
<stop stop-color="#696969"/>
<stop offset="0.142499" stop-color="#8A8A8A"/>
<stop offset="0.199445" stop-color="#A6A6A6"/>
<stop offset="0.335644" stop-color="#D3D3D3"/>
<stop offset="0.3806" stop-color="#DFDEDE"/>
<stop offset="0.555816" stop-color="#F7F7F7"/>
<stop offset="0.647173" stop-color="white"/>
<stop offset="0.797417" stop-color="white"/>
<stop offset="1" stop-color="#F0F0F0"/>
</linearGradient>
<radialGradient id="paint6_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1429.56 1521.18) rotate(-90) scale(39.2388 1.90777)">
<stop stop-opacity="0.376161"/>
<stop offset="1" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint7_linear" x1="1417.79" y1="1487.6" x2="1417.79" y2="408.778" gradientUnits="userSpaceOnUse">
<stop stop-opacity="0.01"/>
<stop offset="0.946386" stop-color="#0D0D0D" stop-opacity="0.01"/>
<stop offset="0.947792" stop-color="#0D0D0D" stop-opacity="0.297441"/>
<stop offset="0.948344" stop-color="#0D0D0D" stop-opacity="0.350515"/>
<stop offset="0.948616" stop-color="#0D0D0D" stop-opacity="0.01"/>
<stop offset="1" stop-opacity="0.01"/>
</linearGradient>
<clipPath id="clip0">
<rect width="15.8196" height="15.8196" fill="white" transform="translate(704.921 25.3114)"/>
</clipPath>
</defs>
<g filter="url(#filter0_i)">
<rect x="1254.18" width="78.4652" height="5.06227" rx="1.26557" fill="url(#paint0_linear)"/>
</g>
<g filter="url(#filter1_i)">
<rect x="1420.6" y="132.252" width="66.4423" height="5.06227" rx="1.26557" transform="rotate(90 1420.6 132.252)" fill="url(#paint1_linear)"/>
</g>
<g filter="url(#filter2_i)">
<rect x="1420.6" y="211.35" width="66.4423" height="5.06227" rx="1.26557" transform="rotate(90 1420.6 211.35)" fill="url(#paint2_linear)"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="0" y="3" width="1418" height="1852">
<path d="M94.6556 3.79675H1322.78C1343.11 3.79675 1360.62 6.85362 1373.7 13.8499C1387.79 21.3866 1399.85 33.4424 1407.38 47.5348C1414.38 60.6167 1417.44 78.1229 1417.44 98.4523V1759.4C1417.44 1779.73 1414.38 1797.24 1407.38 1810.32C1399.85 1824.41 1387.79 1836.47 1373.7 1844C1360.62 1851 1343.11 1854.06 1322.78 1854.06H94.6556C75.1485 1854.06 56.4246 1850.49 43.1053 1843.37C29.0129 1835.83 18.2226 1825.04 10.6859 1810.95C3.5627 1797.63 0 1778.91 0 1759.4V98.4523C0 78.1229 3.05687 60.6167 10.0532 47.5348C17.5899 33.4424 29.6457 21.3866 43.7381 13.8499C56.82 6.85362 74.3261 3.79675 94.6556 3.79675Z" fill="white"/>
</mask>
<g mask="url(#mask0)">
<g filter="url(#filter3_ii)">
<path d="M94.6556 3.79675H1322.78C1343.11 3.79675 1360.62 6.85362 1373.7 13.8499C1387.79 21.3866 1399.85 33.4424 1407.38 47.5348C1414.38 60.6167 1417.44 78.1229 1417.44 98.4523V1759.4C1417.44 1779.73 1414.38 1797.24 1407.38 1810.32C1399.85 1824.41 1387.79 1836.47 1373.7 1844C1360.62 1851 1343.11 1854.06 1322.78 1854.06H94.6556C75.1485 1854.06 56.4246 1850.49 43.1053 1843.37C29.0129 1835.83 18.2226 1825.04 10.6859 1810.95C3.5627 1797.63 0 1778.91 0 1759.4V98.4523C0 78.1229 3.05687 60.6167 10.0532 47.5348C17.5899 33.4424 29.6457 21.3866 43.7381 13.8499C56.82 6.85362 74.3261 3.79675 94.6556 3.79675Z" fill="#3B3B3B"/>
</g>
</g>
<path d="M94.6557 10.7573C77.9818 10.7573 60.1717 12.9546 47.0208 19.9878C34.1414 26.8758 23.0792 37.938 16.1912 50.8174C9.158 63.9683 6.96069 81.7784 6.96069 98.4523V1759.4C6.96069 1776.07 9.79078 1794.52 16.824 1807.67C23.712 1820.55 33.5086 1830.34 46.388 1837.23C59.5389 1844.27 77.9818 1847.1 94.6557 1847.1H1322.78C1339.45 1847.1 1357.26 1844.9 1370.41 1837.86C1383.29 1830.98 1394.36 1819.91 1401.24 1807.04C1408.28 1793.88 1410.47 1776.07 1410.47 1759.4V98.4523C1410.47 81.7784 1408.28 63.9683 1401.24 50.8174C1394.36 37.938 1383.29 26.8758 1370.41 19.9878C1357.26 12.9546 1339.45 10.7573 1322.78 10.7573H94.6557Z" fill="#131313"/>
<path d="M88.3277 62.0128C79.2019 62.0128 74.9613 62.8317 70.5599 65.1856C66.6127 67.2966 63.4998 70.4095 61.3888 74.3567C59.035 78.758 58.2161 82.9986 58.2161 92.1245V1765.73C58.2161 1774.85 59.035 1779.09 61.3888 1783.5C63.4998 1787.44 66.6127 1790.56 70.5599 1792.67C74.9613 1795.02 79.2019 1795.84 88.3277 1795.84H1329.11C1338.23 1795.84 1342.47 1795.02 1346.88 1792.67C1350.82 1790.56 1353.94 1787.44 1356.05 1783.5C1358.4 1779.09 1359.22 1774.85 1359.22 1765.73V92.1245C1359.22 82.9986 1358.4 78.758 1356.05 74.3567C1353.94 70.4095 1350.82 67.2966 1346.88 65.1856C1342.47 62.8317 1338.23 62.0128 1329.11 62.0128H88.3277Z" fill="#1B1E1F"/>
<circle cx="620.128" cy="32.9047" r="10.1245" fill="#0A0A0A"/>
<circle cx="665.056" cy="32.9047" r="12.6557" fill="#0A0A0A"/>
<circle cx="798.573" cy="32.9047" r="12.6557" fill="#0A0A0A"/>
<circle cx="753.645" cy="32.9047" r="2.53113" fill="#0A0A0A"/>
<g clip-path="url(#clip0)">
<circle cx="712.831" cy="33.2212" r="7.90979" fill="url(#paint3_radial)"/>
<g opacity="0.387535" filter="url(#filter4_dd)">
<circle cx="712.831" cy="33.2212" r="4.74588" fill="url(#paint4_linear)"/>
</g>
<mask id="mask1" mask-type="alpha" maskUnits="userSpaceOnUse" x="708" y="28" width="10" height="10">
<circle cx="712.831" cy="33.2212" r="4.74588" fill="white"/>
</mask>
<g mask="url(#mask1)">
<g filter="url(#filter5_f)">
<ellipse cx="709.043" cy="32.5983" rx="3.92154" ry="1.31422" transform="rotate(-76 709.043 32.5983)" fill="#3E89CC"/>
</g>
<g filter="url(#filter6_f)">
<ellipse cx="715.995" cy="31.9557" rx="2.84753" ry="3.48031" fill="#1C5894"/>
</g>
<g filter="url(#filter7_f)">
<ellipse cx="713.479" cy="36.7441" rx="4.14883" ry="2.80429" transform="rotate(-16 713.479 36.7441)" fill="#0A152B"/>
</g>
</g>
</g>

<g filter="url(#filter8_i)">
<path d="M1444.01 1502.04C1429.33 1502.04 1417.44 1490.14 1417.44 1475.46V515.531C1417.44 509.205 1421.32 488.113 1425.71 466.397C1425.72 466.349 1430.04 466.34 1430.04 466.34V464.135C1430.04 464.135 1426.18 464.183 1426.19 464.135C1429.96 445.596 1434.05 426.641 1436.25 416.795C1437.39 411.696 1439.55 408.778 1444.01 408.778C1448.47 408.778 1450.63 411.623 1451.78 416.808C1453.94 426.508 1458.04 445.573 1461.82 464.135C1461.82 464.153 1458.38 464.135 1458.38 464.135V466.34C1458.38 466.34 1462.29 466.318 1462.29 466.34C1466.69 488.068 1470.59 509.212 1470.59 515.531V1475.46C1470.59 1490.14 1458.69 1502.04 1444.01 1502.04Z" fill="url(#paint5_linear)"/>
<path d="M1444.01 1502.04C1429.33 1502.04 1417.44 1490.14 1417.44 1475.46V515.531C1417.44 509.205 1421.32 488.113 1425.71 466.397C1425.72 466.349 1430.04 466.34 1430.04 466.34V464.135C1430.04 464.135 1426.18 464.183 1426.19 464.135C1429.96 445.596 1434.05 426.641 1436.25 416.795C1437.39 411.696 1439.55 408.778 1444.01 408.778C1448.47 408.778 1450.63 411.623 1451.78 416.808C1453.94 426.508 1458.04 445.573 1461.82 464.135C1461.82 464.153 1458.38 464.135 1458.38 464.135V466.34C1458.38 466.34 1462.29 466.318 1462.29 466.34C1466.69 488.068 1470.59 509.212 1470.59 515.531V1475.46C1470.59 1490.14 1458.69 1502.04 1444.01 1502.04Z" fill="url(#paint6_radial)"/>
<path d="M1444.01 1502.04C1429.33 1502.04 1417.44 1490.14 1417.44 1475.46V515.531C1417.44 509.205 1421.32 488.113 1425.71 466.397C1425.72 466.349 1430.04 466.34 1430.04 466.34V464.135C1430.04 464.135 1426.18 464.183 1426.19 464.135C1429.96 445.596 1434.05 426.641 1436.25 416.795C1437.39 411.696 1439.55 408.778 1444.01 408.778C1448.47 408.778 1450.63 411.623 1451.78 416.808C1453.94 426.508 1458.04 445.573 1461.82 464.135C1461.82 464.153 1458.38 464.135 1458.38 464.135V466.34C1458.38 466.34 1462.29 466.318 1462.29 466.34C1466.69 488.068 1470.59 509.212 1470.59 515.531V1475.46C1470.59 1490.14 1458.69 1502.04 1444.01 1502.04Z" fill="url(#paint7_linear)"/>
</g>


</svg>
''',
    frameSize: Size(1471.0, 1855.0),
    screenSize: Size(1024.0, 1366.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.iOS,
      DeviceType.phone,
      'iphone-11promax',
    ),
    name: 'iPhone 11 Pro Max',
    pixelRatio: 3.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 44.0,
      right: 0.0,
      bottom: 34.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 44.0,
      top: 0.0,
      right: 44.0,
      bottom: 21.0,
    ),
    screenPath: parseSvgPathData(
        'M64.1336 92.1448C55.8518 108.399 55.8518 129.677 55.8518 172.232V1674.78C55.8518 1717.33 55.8518 1738.61 64.1336 1754.87C71.4185 1769.16 83.0427 1780.79 97.3401 1788.07C113.594 1796.35 134.872 1796.35 177.427 1796.35H740.883C783.438 1796.35 804.716 1796.35 820.97 1788.07C835.267 1780.79 846.891 1769.16 854.176 1754.87C862.458 1738.61 862.458 1717.33 862.458 1674.78V172.232C862.458 129.677 862.458 108.399 854.176 92.1448C846.891 77.8474 835.267 66.2232 820.97 58.9383C804.716 50.6565 783.438 50.6565 740.882 50.6565H177.427C134.872 50.6565 113.594 50.6565 97.3401 58.9383C83.0427 66.2232 71.4185 77.8474 64.1336 92.1448ZM663.729 62.3465C663.914 55.8904 668.963 50.6565 675.419 50.6565H242.891C249.347 50.6565 254.405 55.8904 254.581 62.3465C254.933 75.2887 256.903 82.1153 260.306 88.4774C264.042 95.4625 269.523 100.944 276.509 104.68C283.494 108.416 291.008 110.405 306.6 110.405H611.71C627.302 110.405 634.816 108.416 641.801 104.68C648.786 100.944 654.268 95.4625 658.004 88.4774C661.408 82.1121 663.356 75.3083 663.729 62.3465Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="918" height="1848" viewBox="0 0 918 1848" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_i" x="10.3911" y="5.19556" width="897.528" height="1836.62" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="2.59777"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.6 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter1_i" x="414.66" y="1844.41" width="86.3914" height="3.24721" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.649441"/>
<feGaussianBlur stdDeviation="0.974162"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.299054 0 0 0 0 0.299054 0 0 0 0 0.299054 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter2_i" x="19.4833" y="37.0181" width="60.796" height="1773.59" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-7.14386"/>
<feGaussianBlur stdDeviation="5.52025"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.6 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter3_i" x="830.889" y="37.0181" width="60.796" height="1773.59" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-7.14386"/>
<feGaussianBlur stdDeviation="5.52025"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.6 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter4_ii" x="0" y="226.655" width="7.14385" height="68.8408" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="3.89665"/>
<feGaussianBlur stdDeviation="0.974162"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-3.89665"/>
<feGaussianBlur stdDeviation="0.974162"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter5_ii" x="0" y="345.503" width="7.14385" height="127.29" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="3.89665"/>
<feGaussianBlur stdDeviation="0.974162"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-3.89665"/>
<feGaussianBlur stdDeviation="0.974162"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter6_ii" x="0" y="499.42" width="7.14385" height="127.29" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="3.89665"/>
<feGaussianBlur stdDeviation="0.974162"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-3.89665"/>
<feGaussianBlur stdDeviation="0.974162"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter7_ii" x="910.517" y="385.768" width="7.14385" height="200.028" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="3.89665"/>
<feGaussianBlur stdDeviation="0.974162"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-3.89665"/>
<feGaussianBlur stdDeviation="0.974162"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.757614 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter8_iii" x="408.499" y="63.6453" width="101.313" height="15.5866" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="2.59777" operator="erode" in="SourceAlpha" result="effect1_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.29888"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.795035 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-2.59777"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.80013 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-1.29888"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.197067 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
</filter>
<filter id="filter9_dd" x="533.841" y="55.2026" width="29.8743" height="29.8743" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="3.89665" operator="dilate" in="SourceAlpha" result="effect1_dropShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="1.94832"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.4 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feMorphology radius="1.29888" operator="dilate" in="SourceAlpha" result="effect2_dropShadow"/>
<feOffset/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
</filter>
<filter id="filter10_f" x="536.746" y="58.9092" width="12.5961" height="19.3299" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.94859" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter11_f" x="546.179" y="59.0987" width="16.2371" height="18.8349" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.94859" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter12_f" x="541.048" y="68.6036" width="18.3466" height="14.6071" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.46297" result="effect1_foregroundBlur"/>
</filter>
<linearGradient id="paint0_linear" x1="10.3911" y1="5.19556" x2="10.3911" y2="1841.82" gradientUnits="userSpaceOnUse">
<stop stop-color="#C9C6C8"/>
<stop offset="0.0168336" stop-color="#2C2A2A"/>
<stop offset="0.0782507" stop-color="#C9C6C8"/>
<stop offset="0.920557" stop-color="#C9C6C8"/>
<stop offset="0.980426" stop-color="#2C2A2A"/>
<stop offset="1" stop-color="#C9C6C8"/>
</linearGradient>
<linearGradient id="paint1_linear" x1="430.169" y1="13.6382" x2="430.169" y2="129.996" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.7"/>
<stop offset="1" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="491.152" y1="1830.78" x2="491.152" y2="1702.33" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.7"/>
<stop offset="1" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="462.898" y1="1836.62" x2="462.898" y2="1815.52" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.75"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="454.758" y1="10.7559" x2="454.758" y2="23.7205" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.75"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="16.8855" y1="13.6382" x2="16.8855" y2="1833.37" gradientUnits="userSpaceOnUse">
<stop stop-color="#5F5F5F"/>
<stop offset="0.0101238" stop-color="#222222"/>
<stop offset="1" stop-color="#252525"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="26.6272" y1="23.3799" x2="26.6272" y2="1823.63" gradientUnits="userSpaceOnUse">
<stop stop-color="#6D6D6D"/>
<stop offset="0.0161168"/>
<stop offset="0.984697"/>
<stop offset="1" stop-color="#5C5C5C"/>
</linearGradient>
<radialGradient id="paint7_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(438.808 1805.5) rotate(90) scale(521.289 182.868)">
<stop stop-color="white" stop-opacity="0.151268"/>
<stop offset="1" stop-color="white" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint8_linear" x1="1.94181" y1="266.744" x2="3.90546" y2="266.744" gradientUnits="userSpaceOnUse">
<stop stop-color="#A5A5A5"/>
<stop offset="0.00734796" stop-color="#E2E2E2"/>
<stop offset="0.994739" stop-color="#BEBEBE"/>
<stop offset="1" stop-color="#9D9D9D"/>
</linearGradient>
<linearGradient id="paint9_linear" x1="1.94181" y1="419.918" x2="3.90546" y2="419.918" gradientUnits="userSpaceOnUse">
<stop stop-color="#A5A5A5"/>
<stop offset="0.00734796" stop-color="#E2E2E2"/>
<stop offset="0.994739" stop-color="#BEBEBE"/>
<stop offset="1" stop-color="#9D9D9D"/>
</linearGradient>
<linearGradient id="paint10_linear" x1="1.94181" y1="573.835" x2="3.90546" y2="573.835" gradientUnits="userSpaceOnUse">
<stop stop-color="#A5A5A5"/>
<stop offset="0.00734796" stop-color="#E2E2E2"/>
<stop offset="0.994739" stop-color="#BEBEBE"/>
<stop offset="1" stop-color="#9D9D9D"/>
</linearGradient>
<linearGradient id="paint11_linear" x1="915.192" y1="477.459" x2="915.082" y2="477.459" gradientUnits="userSpaceOnUse">
<stop stop-color="#8E8E8E"/>
<stop offset="1" stop-color="#BCBCBC"/>
</linearGradient>
<linearGradient id="paint12_linear" x1="917.661" y1="387.716" x2="917.661" y2="583.848" gradientUnits="userSpaceOnUse">
<stop stop-opacity="0.996971"/>
<stop offset="0.0951211" stop-opacity="0.01"/>
<stop offset="0.895463" stop-opacity="0.01"/>
<stop offset="1" stop-opacity="0.881058"/>
</linearGradient>
<radialGradient id="paint13_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(568.16 93.0863) rotate(45.1938) scale(27.4569)">
<stop stop-color="#434343"/>
<stop offset="1" stop-color="#121212"/>
</radialGradient>
<linearGradient id="paint14_linear" x1="548.778" y1="48.7081" x2="548.778" y2="77.2836" gradientUnits="userSpaceOnUse">
<stop stop-color="#2A4893"/>
<stop offset="1" stop-color="#213054"/>
</linearGradient>
<clipPath id="clip0">
<rect width="96.1173" height="2.59777" fill="white" transform="translate(409.797 1844.41)"/>
</clipPath>
<clipPath id="clip1">
<rect width="917.661" height="396.159" fill="white" transform="translate(0 228.603)"/>
</clipPath>
<clipPath id="clip2">
<rect width="101.313" height="15.5866" fill="white" transform="translate(408.499 63.6453)"/>
</clipPath>
<clipPath id="clip3">
<rect width="27.2765" height="27.2765" fill="white" transform="translate(535.14 56.5015)"/>
</clipPath>
</defs>
<path fill-rule="evenodd" clip-rule="evenodd" d="M151.961 0H763.751C802.321 0 823.787 4.16193 846.177 16.1359C867.387 27.4794 884.336 44.4284 895.68 65.6389C907.654 88.0283 911.816 109.494 911.816 148.064V1698.95C911.816 1737.52 907.654 1758.98 895.68 1781.37C884.336 1802.58 867.387 1819.53 846.177 1830.88C823.787 1842.85 802.321 1847.01 763.751 1847.01H151.961C113.391 1847.01 91.925 1842.85 69.5356 1830.88C48.3251 1819.53 31.3761 1802.58 20.0326 1781.37C8.05866 1758.98 3.89673 1737.52 3.89673 1698.95V148.064C3.89673 109.494 8.05866 88.0283 20.0326 65.6389C31.3761 44.4284 48.3251 27.4794 69.5356 16.1359C91.925 4.16193 113.391 0 151.961 0Z" fill="black"/>
<g filter="url(#filter0_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M153.26 5.19556H765.05C802.794 5.19556 823.467 9.18762 845.025 20.7174C865.331 31.5767 881.538 47.7841 892.397 68.0891C903.927 89.648 907.919 110.321 907.919 148.064V1698.95C907.919 1736.69 903.927 1757.36 892.397 1778.92C881.538 1799.23 865.331 1815.43 845.025 1826.29C823.467 1837.82 802.794 1841.82 765.05 1841.82H153.26C115.516 1841.82 94.8436 1837.82 73.2847 1826.29C52.9796 1815.43 36.7723 1799.23 25.913 1778.92C14.3832 1757.36 10.3911 1736.69 10.3911 1698.95V148.064C10.3911 110.321 14.3832 89.648 25.913 68.0891C36.7723 47.7841 52.9796 31.5767 73.2847 20.7174C94.8436 9.18762 115.516 5.19556 153.26 5.19556Z" fill="url(#paint0_linear)"/>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M150.604 13.6382H767.706C805.778 13.6382 826.63 17.5879 848.376 28.9954C868.857 39.7395 885.205 55.7749 896.159 75.8646C907.789 97.1947 911.816 117.648 911.816 154.991V1689.42C911.816 1726.77 907.789 1747.22 896.159 1768.55C885.205 1788.64 868.857 1804.67 848.376 1815.42C826.63 1826.83 805.778 1830.77 767.706 1830.77H150.604C112.532 1830.77 91.6801 1826.83 69.9341 1815.42C49.4527 1804.67 33.1046 1788.64 22.151 1768.55C10.5211 1747.22 6.49438 1726.77 6.49438 1689.42V154.991C6.49438 117.648 10.5211 97.1947 22.151 75.8646C33.1046 55.7749 49.4527 39.7395 69.9341 28.9954C91.6801 17.5879 112.532 13.6382 150.604 13.6382Z" fill="url(#paint1_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M150.604 13.6382H767.706C805.778 13.6382 826.63 17.5879 848.376 28.9954C868.857 39.7395 885.205 55.7749 896.159 75.8646C907.789 97.1947 911.816 117.648 911.816 154.991V1689.42C911.816 1726.77 907.789 1747.22 896.159 1768.55C885.205 1788.64 868.857 1804.67 848.376 1815.42C826.63 1826.83 805.778 1830.77 767.706 1830.77H150.604C112.532 1830.77 91.6801 1826.83 69.9341 1815.42C49.4527 1804.67 33.1046 1788.64 22.151 1768.55C10.5211 1747.22 6.49438 1726.77 6.49438 1689.42V154.991C6.49438 117.648 10.5211 97.1947 22.151 75.8646C33.1046 55.7749 49.4527 39.7395 69.9341 28.9954C91.6801 17.5879 112.532 13.6382 150.604 13.6382Z" fill="url(#paint2_linear)"/>
<g opacity="0.500781">
<path fill-rule="evenodd" clip-rule="evenodd" d="M160.372 10.3911H755.34C792.046 10.3911 812.151 14.3606 833.117 25.8252C852.863 36.623 868.625 52.7387 879.186 72.9289C890.399 94.3658 894.281 114.921 894.281 152.452V1694.56C894.281 1732.09 890.399 1752.65 879.186 1774.08C868.625 1794.27 852.863 1810.39 833.117 1821.19C812.151 1832.65 792.046 1836.62 755.34 1836.62H160.372C123.666 1836.62 103.562 1832.65 82.5959 1821.19C62.8491 1810.39 47.0874 1794.27 36.5267 1774.08C25.3139 1752.65 21.4316 1732.09 21.4316 1694.56V152.452C21.4316 114.921 25.3139 94.3658 36.5267 72.9289C47.0874 52.7387 62.8491 36.623 82.5959 25.8252C103.562 14.3606 123.666 10.3911 160.372 10.3911Z" fill="url(#paint3_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M160.372 10.3911H755.34C792.046 10.3911 812.151 14.3606 833.117 25.8252C852.863 36.623 868.625 52.7387 879.186 72.9289C890.399 94.3658 894.281 114.921 894.281 152.452V1694.56C894.281 1732.09 890.399 1752.65 879.186 1774.08C868.625 1794.27 852.863 1810.39 833.117 1821.19C812.151 1832.65 792.046 1836.62 755.34 1836.62H160.372C123.666 1836.62 103.562 1832.65 82.5959 1821.19C62.8491 1810.39 47.0874 1794.27 36.5267 1774.08C25.3139 1752.65 21.4316 1732.09 21.4316 1694.56V152.452C21.4316 114.921 25.3139 94.3658 36.5267 72.9289C47.0874 52.7387 62.8491 36.623 82.5959 25.8252C103.562 14.3606 123.666 10.3911 160.372 10.3911Z" fill="url(#paint4_linear)"/>
</g>
<path d="M151.312 14.6123H766.999C803.391 14.6123 822.565 18.3421 842.533 29.0213C861.197 39.0029 876.06 53.866 886.042 72.53C896.721 92.4982 900.45 111.671 900.45 148.064V1698.95C900.45 1735.34 896.721 1754.51 886.042 1774.48C876.06 1793.15 861.197 1808.01 842.533 1817.99C822.565 1828.67 803.391 1832.4 766.999 1832.4H151.312C114.919 1832.4 95.7456 1828.67 75.7774 1817.99C57.1133 1808.01 42.2502 1793.15 32.2686 1774.48C21.5895 1754.51 17.8597 1735.34 17.8597 1698.95V148.064C17.8597 111.671 21.5895 92.4982 32.2686 72.53C42.2502 53.866 57.1133 39.0029 75.7774 29.0213C95.7456 18.3421 114.919 14.6123 151.312 14.6123Z" fill="url(#paint5_linear)" stroke="black" stroke-width="1.94832"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M151.876 23.3799H766.434C801.191 23.3799 819.262 26.6931 838.157 36.7526C855.371 45.9171 869.044 59.5287 878.25 76.6648C888.355 95.4745 891.683 113.464 891.683 148.064V1698.95C891.683 1733.55 888.355 1751.54 878.25 1770.35C869.044 1787.48 855.371 1801.09 838.157 1810.26C819.262 1820.32 801.191 1823.63 766.434 1823.63H151.876C117.119 1823.63 99.0481 1820.32 80.1533 1810.26C62.9396 1801.09 49.2664 1787.48 40.0604 1770.35C29.9554 1751.54 26.6272 1733.55 26.6272 1698.95V148.064C26.6272 113.464 29.9554 95.4745 40.0604 76.6648C49.2664 59.5287 62.9396 45.9171 80.1533 36.7526C99.0481 26.6931 117.119 23.3799 151.876 23.3799Z" fill="url(#paint6_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M151.876 23.3799H766.434C801.191 23.3799 819.262 26.6931 838.157 36.7526C855.371 45.9171 869.044 59.5287 878.25 76.6648C888.355 95.4745 891.683 113.464 891.683 148.064V1698.95C891.683 1733.55 888.355 1751.54 878.25 1770.35C869.044 1787.48 855.371 1801.09 838.157 1810.26C819.262 1820.32 801.191 1823.63 766.434 1823.63H151.876C117.119 1823.63 99.0481 1820.32 80.1533 1810.26C62.9396 1801.09 49.2664 1787.48 40.0604 1770.35C29.9554 1751.54 26.6272 1733.55 26.6272 1698.95V148.064C26.6272 113.464 29.9554 95.4745 40.0604 76.6648C49.2664 59.5287 62.9396 45.9171 80.1533 36.7526C99.0481 26.6931 117.119 23.3799 151.876 23.3799Z" fill="url(#paint7_radial)"/>
<path d="M153.26 35.0698H765.05C798.284 35.0698 814.297 38.1622 830.937 47.0609C846.036 55.1359 857.979 67.0789 866.054 82.1778C874.952 98.8171 878.045 114.831 878.045 148.064V1698.95C878.045 1732.18 874.952 1748.19 866.054 1764.83C857.979 1779.93 846.036 1791.88 830.937 1799.95C814.297 1808.85 798.284 1811.94 765.05 1811.94H153.26C120.026 1811.94 104.013 1808.85 87.3734 1799.95C72.2744 1791.88 60.3315 1779.93 52.2565 1764.83C43.3577 1748.19 40.2654 1732.18 40.2654 1698.95V148.064C40.2654 114.831 43.3577 98.8171 52.2565 82.1778C60.3315 67.0789 72.2744 55.1359 87.3734 47.0609C104.013 38.1622 120.026 35.0698 153.26 35.0698Z" fill="black"/>
<g clip-path="url(#clip0)">
<g filter="url(#filter1_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M416.119 1844.41C433.42 1844.41 482.146 1844.41 499.593 1844.41C501.913 1844.41 501.288 1847.01 498.969 1847.01H416.743C414.424 1847.01 413.799 1844.41 416.119 1844.41Z" fill="#191919"/>
</g>
</g>
<g filter="url(#filter2_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M80.1533 1810.6C62.9396 1801.43 49.2664 1787.82 40.0604 1770.68C29.9554 1751.87 26.6272 1733.88 26.6272 1699.28V148.401C26.6272 113.801 29.9554 95.8112 40.0604 77.0015C49.2664 59.8653 62.9396 46.2537 80.1533 37.0892C82.9144 35.6192 39.411 56.4765 39.411 141.907C39.411 415.877 39.411 1272.3 39.411 1705.78C39.411 1787.89 81.4395 1811.28 80.1533 1810.6Z" fill="white" fill-opacity="0.599524"/>
</g>
<g filter="url(#filter3_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M838.159 1810.6C855.373 1801.43 869.046 1787.82 878.252 1770.68C888.357 1751.87 891.685 1733.88 891.685 1699.28V148.401C891.685 113.801 888.357 95.8112 878.252 77.0015C869.046 59.8653 855.373 46.2537 838.159 37.0892C835.398 35.6192 878.901 56.4765 878.901 141.907C878.901 415.877 878.901 1272.3 878.901 1705.78C878.901 1787.89 836.873 1811.28 838.159 1810.6Z" fill="white" fill-opacity="0.599524"/>
</g>
<rect opacity="0.602808" x="3.89673" y="163.01" width="14.9372" height="11.0405" fill="black"/>
<rect opacity="0.602808" x="899.476" y="163.01" width="12.3394" height="11.0405" fill="black"/>
<rect opacity="0.602808" x="3.89673" y="1672.96" width="14.9372" height="11.0405" fill="black"/>
<rect opacity="0.602808" x="899.476" y="1672.96" width="12.3394" height="11.0405" fill="black"/>
<rect opacity="0.602808" x="740.363" y="14.9373" width="14.9372" height="11.0405" transform="rotate(-90 740.363 14.9373)" fill="black"/>
<rect opacity="0.602808" x="166.906" y="1847.01" width="14.9372" height="11.0405" transform="rotate(-90 166.906 1847.01)" fill="black"/>
<g clip-path="url(#clip1)">
<g filter="url(#filter4_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M4.53375 228.603C2.02983 228.603 0 230.639 0 233.149V289.001C0 291.512 2.02983 293.547 4.53375 293.547H7.12446C7.12446 290.131 7.1681 231.942 7.12446 228.603H4.53375Z" fill="url(#paint8_linear)"/>
</g>
<g filter="url(#filter5_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M4.53375 347.451C3.05967 347.814 1.29204 348.743 0.348186 350.063C0.153776 350.335 0 351.196 0 351.444C0 363.927 0 401.945 0 465.501C0 465.766 0.216445 467.108 0.348973 467.433C1.11276 469.308 2.43986 469.761 4.53375 470.845H7.12446C7.12446 467.429 7.1681 350.79 7.12446 347.451H4.53375Z" fill="url(#paint9_linear)"/>
</g>
<g filter="url(#filter6_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M4.53375 501.369C3.05967 501.732 1.29204 502.661 0.348186 503.981C0.153776 504.253 0 505.113 0 505.362C0 517.844 0 555.863 0 619.419C0 619.684 0.216445 621.025 0.348973 621.351C1.11276 623.225 2.43986 623.679 4.53375 624.762H7.12446C7.12446 621.347 7.1681 504.708 7.12446 501.369H4.53375Z" fill="url(#paint10_linear)"/>
</g>
<g filter="url(#filter7_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M913.127 387.716C914.601 388.079 916.369 389.009 917.312 390.329C917.507 390.601 917.661 391.461 917.661 391.71C917.661 404.192 917.661 514.948 917.661 578.504C917.661 578.769 917.444 580.11 917.312 580.436C916.548 582.31 915.221 582.764 913.127 583.848H910.536C910.536 580.432 910.493 391.055 910.536 387.716H913.127Z" fill="url(#paint11_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M913.127 387.716C914.601 388.079 916.369 389.009 917.312 390.329C917.507 390.601 917.661 391.461 917.661 391.71C917.661 404.192 917.661 514.948 917.661 578.504C917.661 578.769 917.444 580.11 917.312 580.436C916.548 582.31 915.221 582.764 913.127 583.848H910.536C910.536 580.432 910.493 391.055 910.536 387.716H913.127Z" fill="url(#paint12_linear)"/>
</g>
</g>
<g opacity="0.801364" clip-path="url(#clip2)">
<rect x="408.499" y="63.6453" width="101.313" height="15.5866" rx="7.7933" fill="#1D1C1C"/>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="408" y="63" width="102" height="17">
<rect x="408.499" y="63.6453" width="101.313" height="15.5866" rx="7.7933" fill="white"/>
</mask>
<g mask="url(#mask0)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M408.499 63.6453H509.811V64.7818H408.499V63.6453ZM408.499 67.0548H509.811V68.1913H408.499V67.0548ZM509.811 69.8961H408.499V71.0326H509.811V69.8961ZM408.499 73.3057H509.811V74.4422H408.499V73.3057ZM509.811 76.147H408.499V77.2835H509.811V76.147Z" fill="black" fill-opacity="0.15"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M408.499 66.2429H509.811V67.3794H408.499V66.2429ZM408.499 69.6525H509.811V70.789H408.499V69.6525ZM509.811 72.4938H408.499V73.6303H509.811V72.4938ZM408.499 75.9033H509.811V77.0399H408.499V75.9033ZM509.811 78.7446H408.499V79.8812H509.811V78.7446Z" fill="white" fill-opacity="0.03"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M414.227 63.6453H415.379V79.2319H414.227V63.6453ZM410.771 63.6453H411.923V79.2319H410.771V63.6453ZM418.259 63.6453H417.107V79.2319H418.259V63.6453ZM420.563 63.6453H421.715V79.2319H420.563V63.6453ZM424.595 63.6453H423.443V79.2319H424.595V63.6453ZM426.899 63.6453H428.051V79.2319H426.899V63.6453ZM430.931 63.6453H429.779V79.2319H430.931V63.6453ZM433.235 63.6453H434.387V79.2319H433.235V63.6453ZM437.267 63.6453H436.115V79.2319H437.267V63.6453ZM439.571 63.6453H440.723V79.2319H439.571V63.6453ZM443.603 63.6453H442.451V79.2319H443.603V63.6453ZM445.907 63.6453H447.059V79.2319H445.907V63.6453ZM449.939 63.6453H448.787V79.2319H449.939V63.6453ZM452.243 63.6453H453.395V79.2319H452.243V63.6453ZM456.851 63.6453H455.699V79.2319H456.851V63.6453ZM458.579 63.6453H459.731V79.2319H458.579V63.6453ZM463.187 63.6453H462.035V79.2319H463.187V63.6453ZM464.915 63.6453H466.067V79.2319H464.915V63.6453ZM469.523 63.6453H468.371V79.2319H469.523V63.6453ZM471.251 63.6453H472.403V79.2319H471.251V63.6453ZM475.859 63.6453H474.707V79.2319H475.859V63.6453ZM477.586 63.6453H478.738V79.2319H477.586V63.6453ZM482.194 63.6453H481.043V79.2319H482.194V63.6453ZM483.923 63.6453H485.074V79.2319H483.923V63.6453ZM488.53 63.6453H487.378V79.2319H488.53V63.6453ZM490.258 63.6453H491.41V79.2319H490.258V63.6453ZM494.866 63.6453H493.714V79.2319H494.866V63.6453ZM497.17 63.6453H498.322V79.2319H497.17V63.6453ZM501.202 63.6453H500.05V79.2319H501.202V63.6453ZM503.506 63.6453H504.658V79.2319H503.506V63.6453ZM507.538 63.6453H506.386V79.2319H507.538V63.6453Z" fill="black" fill-opacity="0.15"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M411.579 63.6453H412.731V79.2319H411.579V63.6453ZM408.123 63.6453H409.275V79.2319H408.123V63.6453ZM415.611 63.6453H414.459V79.2319H415.611V63.6453ZM417.915 63.6453H419.067V79.2319H417.915V63.6453ZM421.947 63.6453H420.795V79.2319H421.947V63.6453ZM424.251 63.6453H425.403V79.2319H424.251V63.6453ZM428.283 63.6453H427.131V79.2319H428.283V63.6453ZM430.587 63.6453H431.739V79.2319H430.587V63.6453ZM434.619 63.6453H433.467V79.2319H434.619V63.6453ZM436.923 63.6453H438.075V79.2319H436.923V63.6453ZM440.955 63.6453H439.803V79.2319H440.955V63.6453ZM443.258 63.6453H444.41V79.2319H443.258V63.6453ZM447.29 63.6453H446.138V79.2319H447.29V63.6453ZM449.594 63.6453H450.746V79.2319H449.594V63.6453ZM454.202 63.6453H453.05V79.2319H454.202V63.6453ZM455.93 63.6453H457.082V79.2319H455.93V63.6453ZM460.538 63.6453H459.386V79.2319H460.538V63.6453ZM462.266 63.6453H463.418V79.2319H462.266V63.6453ZM466.874 63.6453H465.722V79.2319H466.874V63.6453ZM468.602 63.6453H469.754V79.2319H468.602V63.6453ZM473.21 63.6453H472.058V79.2319H473.21V63.6453ZM474.938 63.6453H476.09V79.2319H474.938V63.6453ZM479.546 63.6453H478.394V79.2319H479.546V63.6453ZM481.274 63.6453H482.426V79.2319H481.274V63.6453ZM485.882 63.6453H484.73V79.2319H485.882V63.6453ZM487.61 63.6453H488.762V79.2319H487.61V63.6453ZM492.218 63.6453H491.066V79.2319H492.218V63.6453ZM494.522 63.6453H495.674V79.2319H494.522V63.6453ZM498.554 63.6453H497.402V79.2319H498.554V63.6453ZM500.858 63.6453H502.01V79.2319H500.858V63.6453ZM504.89 63.6453H503.738V79.2319H504.89V63.6453Z" fill="white" fill-opacity="0.03"/>
</g>
<g opacity="0.244441" filter="url(#filter8_iii)">
<rect x="408.499" y="63.6453" width="101.313" height="15.5866" rx="7.7933" fill="black" fill-opacity="0.01"/>
</g>
<mask id="mask1" mask-type="alpha" maskUnits="userSpaceOnUse" x="408" y="63" width="102" height="17">
<rect x="408.499" y="63.6453" width="101.313" height="15.5866" rx="7.7933" fill="white"/>
</mask>
<g mask="url(#mask1)">
</g>
</g>
<g clip-path="url(#clip3)">
<circle cx="548.778" cy="70.1397" r="13.6383" fill="url(#paint13_radial)"/>
<g opacity="0.387535" filter="url(#filter9_dd)">
<circle cx="548.778" cy="70.1397" r="7.14385" fill="url(#paint14_linear)"/>
</g>
<mask id="mask2" mask-type="alpha" maskUnits="userSpaceOnUse" x="541" y="62" width="15" height="16">
<circle cx="548.778" cy="70.1397" r="7.14385" fill="white"/>
</mask>
<g mask="url(#mask2)">
<g filter="url(#filter10_f)">
<ellipse cx="543.045" cy="68.5741" rx="5.92335" ry="1.98508" transform="rotate(-76 543.045 68.5741)" fill="#3E89CC"/>
</g>
<g filter="url(#filter11_f)">
<ellipse cx="554.298" cy="68.5161" rx="4.22137" ry="5.52025" fill="#1C5894"/>
</g>
<g filter="url(#filter12_f)">
<ellipse cx="550.222" cy="75.9072" rx="6.38706" ry="4.1683" transform="rotate(-16 550.222 75.9072)" fill="#0A152B"/>
</g>
</g>
</g>



</svg>
''',
    frameSize: Size(918.0, 1848.0),
    screenSize: Size(414.0, 896.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.iOS,
      DeviceType.tablet,
      'ipad-12-9-inch',
    ),
    name: 'iPad 12.9"',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 0.0,
      top: 0.0,
      right: 0.0,
      bottom: 0.0,
    ),
    screenPath: Path()
      ..addRect(
        Rect.fromLTWH(
          0.0,
          0.0,
          1024.0,
          1366.0,
        ),
      ),
    svgFrame:
        '''<svg width="1024" height="1366" viewBox="0 0 1024 1366" fill="none" xmlns="http://www.w3.org/2000/svg">
	<!-- SCREEN SHAPE -->
	
	<!-- DEVICE PROPERTIES -->
	
</svg>
''',
    frameSize: Size(1024.0, 1366.0),
    screenSize: Size(1024.0, 1366.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.macOS,
      DeviceType.laptop,
      'macbook',
    ),
    name: 'Macbook',
    pixelRatio: 2.0,
    safeAreas: EdgeInsets.zero,
    rotatedSafeAreas: null,
    screenPath: parseSvgPathData(
        'M635 346.794H2422.65V1374.63C2422.65 1378.1 2419.84 1380.91 2416.37 1380.91H641.285C637.814 1380.91 635 1378.1 635 1374.63V346.794Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="3064" height="1780" viewBox="0 0 3064 1780" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_i" x="289" y="10" width="2486" height="1727" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="2"/>
<feGaussianBlur stdDeviation="6"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.803612 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter1_ii" x="0" y="1698" width="3064" height="75" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-2"/>
<feGaussianBlur stdDeviation="2"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.284465 0 0 0 0 0.284465 0 0 0 0 0.284465 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="11"/>
<feGaussianBlur stdDeviation="11"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.52423 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter2_f" x="2753.32" y="1738.32" width="23.3547" height="12.3547" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.83868" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter3_f" x="1896.32" y="1738.32" width="23.3547" height="12.3547" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.83868" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter4_f" x="1140.32" y="1738.32" width="23.3547" height="12.3547" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.83868" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter5_f" x="290.323" y="1738.32" width="23.3547" height="12.3547" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.83868" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter6_di" x="1239" y="1700" width="586" height="26" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="2"/>
<feGaussianBlur stdDeviation="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.362776 0 0 0 0 0.362776 0 0 0 0 0.362776 0 0 0 0.300413 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="2"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.345424 0 0 0 0 0.345424 0 0 0 0 0.345424 0 0 0 0.433537 0"/>
<feBlend mode="normal" in2="shape" result="effect2_innerShadow"/>
</filter>
<filter id="filter7_d" x="-2" y="1700" width="3068" height="20" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="2"/>
<feGaussianBlur stdDeviation="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.108073 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter8_ddd" x="564.691" y="259.753" width="1928.58" height="1205.23" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="14.0618"/>
<feGaussianBlur stdDeviation="35.1544"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="28.1236"/>
<feGaussianBlur stdDeviation="21.0927"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.3 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.703089"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.9 0"/>
<feBlend mode="normal" in2="effect2_dropShadow" result="effect3_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect3_dropShadow" result="shape"/>
</filter>
<filter id="filter9_ii" x="635" y="315.297" width="1787.97" height="32.3421" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-0.703089"/>
<feGaussianBlur stdDeviation="0.351544"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.703089"/>
<feGaussianBlur stdDeviation="0.351544"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.6 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
</filter>
<filter id="filter10_bdd" x="345.522" y="93.6771" width="2373.09" height="97.963" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feGaussianBlur in="BackgroundImage" stdDeviation="17.239"/>
<feComposite in2="SourceAlpha" operator="in" result="effect1_backgroundBlur"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="10.147"/>
<feGaussianBlur stdDeviation="12.6838"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/>
<feBlend mode="normal" in2="effect1_backgroundBlur" result="effect2_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="0.634189"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
<feBlend mode="normal" in2="effect2_dropShadow" result="effect3_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect3_dropShadow" result="shape"/>
</filter>
<linearGradient id="paint0_linear" x1="2038.39" y1="-524.936" x2="91.8115" y2="858.598" gradientUnits="userSpaceOnUse">
<stop stop-color="#A5A4A9"/>
<stop offset="1" stop-color="#757479"/>
</linearGradient>
<linearGradient id="paint1_linear" x1="1555.64" y1="-466.026" x2="187.495" y2="-272.838" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.5"/>
<stop offset="0.6405" stop-color="#C4AE99" stop-opacity="0.82025"/>
<stop offset="1" stop-color="#D1B397"/>
</linearGradient>
<linearGradient id="paint2_linear" x1="-563.879" y1="1700" x2="-563.879" y2="1784.82" gradientUnits="userSpaceOnUse">
<stop stop-color="#6B6970"/>
<stop offset="0.372886" stop-color="#67666B"/>
<stop offset="0.693226" stop-color="#363439"/>
<stop offset="1" stop-color="#383838"/>
</linearGradient>
<linearGradient id="paint3_linear" x1="-564.336" y1="1700" x2="-564.336" y2="1784.84" gradientUnits="userSpaceOnUse">
<stop stop-color="white" stop-opacity="0.444322"/>
<stop offset="1" stop-color="#473F38" stop-opacity="0.275108"/>
</linearGradient>
<linearGradient id="paint4_linear" x1="0" y1="1700" x2="0" y2="1762" gradientUnits="userSpaceOnUse">
<stop stop-color="#919191"/>
<stop offset="1" stop-opacity="0.5"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="2749" y1="1744" x2="2749" y2="1751" gradientUnits="userSpaceOnUse">
<stop stop-color="#232227" stop-opacity="0.474015"/>
<stop offset="1" stop-color="#3A393F" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="1892" y1="1744" x2="1892" y2="1751" gradientUnits="userSpaceOnUse">
<stop stop-color="#232227" stop-opacity="0.474015"/>
<stop offset="1" stop-color="#3A393F" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="1136" y1="1744" x2="1136" y2="1751" gradientUnits="userSpaceOnUse">
<stop stop-color="#232227" stop-opacity="0.474015"/>
<stop offset="1" stop-color="#3A393F" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="286" y1="1744" x2="286" y2="1751" gradientUnits="userSpaceOnUse">
<stop stop-color="#232227" stop-opacity="0.474015"/>
<stop offset="1" stop-color="#3A393F" stop-opacity="0.01"/>
</linearGradient>
<linearGradient id="paint9_linear" x1="1823" y1="1695.87" x2="1241" y2="1695.87" gradientUnits="userSpaceOnUse">
<stop stop-color="#484848"/>
<stop offset="0.00583792" stop-color="#6C6C6C"/>
<stop offset="0.0260052" stop-color="#8E8E92"/>
<stop offset="0.226402" stop-color="#C3C2C7"/>
<stop offset="0.501568" stop-color="#C4C3C9"/>
<stop offset="0.724358" stop-color="#C7C6CC"/>
<stop offset="0.950294" stop-color="#C4C3C9"/>
<stop offset="0.978667" stop-color="#A8A7AC"/>
<stop offset="0.989557" stop-color="#9A9A9A"/>
<stop offset="1" stop-color="#5D5D5D"/>
</linearGradient>
<linearGradient id="paint10_linear" x1="1245.18" y1="1699.97" x2="0" y2="1699.97" gradientUnits="userSpaceOnUse">
<stop stop-color="#828282"/>
<stop offset="0.00725779" stop-color="#D3D2D7"/>
<stop offset="0.745353" stop-color="#C5C5C8"/>
<stop offset="0.902807" stop-color="#C2C2C4"/>
<stop offset="0.933421" stop-color="#CAC8CE"/>
<stop offset="0.958117" stop-color="#DDDCE1"/>
<stop offset="0.979433" stop-color="#8C8B90"/>
<stop offset="1" stop-color="#333335"/>
</linearGradient>
<linearGradient id="paint11_linear" x1="1245.18" y1="-0.0269498" x2="0" y2="-0.0269498" gradientUnits="userSpaceOnUse">
<stop stop-color="#828282"/>
<stop offset="0.00725779" stop-color="#D3D2D7"/>
<stop offset="0.745353" stop-color="#C5C5C8"/>
<stop offset="0.902807" stop-color="#C2C2C4"/>
<stop offset="0.933421" stop-color="#CAC8CE"/>
<stop offset="0.958117" stop-color="#DDDCE1"/>
<stop offset="0.979433" stop-color="#8C8B90"/>
<stop offset="1" stop-color="#333335"/>
</linearGradient>
<linearGradient id="paint12_linear" x1="1532" y1="128" x2="1532" y2="1568" gradientUnits="userSpaceOnUse">
<stop stop-color="#221D29"/>
<stop offset="1" stop-color="#293251"/>
</linearGradient>
<linearGradient id="paint13_linear" x1="635" y1="316" x2="635" y2="346.936" gradientUnits="userSpaceOnUse">
<stop stop-color="#E7E6E7"/>
<stop offset="1" stop-color="#E1E1E1"/>
</linearGradient>
<clipPath id="clip0">
<rect width="2480" height="1719" fill="white" transform="translate(292 13)"/>
</clipPath>
<clipPath id="clip1">
<rect width="3064" height="62" fill="white" transform="translate(0 1700)"/>
</clipPath>
<clipPath id="clip2">
<rect width="1787.97" height="1064.61" fill="white" transform="translate(635 316)"/>
</clipPath>
<clipPath id="clip3">
<rect width="1787.97" height="30.9359" fill="white" transform="translate(635 316)"/>
</clipPath>
<clipPath id="clip4">
<rect width="2306" height="27.9703" fill="white" transform="translate(380 128.155)"/>
</clipPath>
<clipPath id="clip5">
<rect width="271.433" height="20.294" fill="white" transform="translate(2385.39 131.96)"/>
</clipPath>
<clipPath id="clip6">
<rect width="454.079" height="21.5624" fill="white" transform="translate(406.636 130.692)"/>
</clipPath>
</defs>
<rect x="282.5" y="4.5" width="2499" height="1752" rx="92.5" fill="black" stroke="url(#paint0_linear)" stroke-width="9"/>
<g clip-path="url(#clip0)">
<g filter="url(#filter0_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M292 99.5834V1645.42C292 1693.23 331.243 1732 379.642 1732H2684.36C2732.76 1732 2772 1693.23 2772 1645.42V99.5834C2772 51.7722 2732.76 13 2684.36 13H379.642C331.242 13 292 51.7667 292 99.5834Z" fill="#262626"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M292 99.5834V1645.42C292 1693.23 331.243 1732 379.642 1732H2684.36C2732.76 1732 2772 1693.23 2772 1645.42V99.5834C2772 51.7722 2732.76 13 2684.36 13H379.642C331.242 13 292 51.7667 292 99.5834Z" fill="url(#paint1_linear)" style="mix-blend-mode:multiply"/>
</g>
<path d="M290.5 99.5834V1645.42C290.5 1694.07 330.432 1733.5 379.642 1733.5H2684.36C2733.57 1733.5 2773.5 1694.08 2773.5 1645.42V99.5834C2773.5 50.9267 2733.57 11.5 2684.36 11.5H379.642C330.431 11.5 290.5 50.9211 290.5 99.5834Z" stroke="#252728" stroke-width="3"/>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="289" y="10" width="2486" height="1725">
<path d="M290.5 99.5834V1645.42C290.5 1694.07 330.432 1733.5 379.642 1733.5H2684.36C2733.57 1733.5 2773.5 1694.08 2773.5 1645.42V99.5834C2773.5 50.9267 2733.57 11.5 2684.36 11.5H379.642C330.431 11.5 290.5 50.9211 290.5 99.5834Z" fill="white"/>
<path d="M290.5 99.5834V1645.42C290.5 1694.07 330.432 1733.5 379.642 1733.5H2684.36C2733.57 1733.5 2773.5 1694.08 2773.5 1645.42V99.5834C2773.5 50.9267 2733.57 11.5 2684.36 11.5H379.642C330.431 11.5 290.5 50.9211 290.5 99.5834Z" stroke="white" stroke-width="3"/>
</mask>
<g mask="url(#mask0)">
<rect x="283.029" y="-110.713" width="2799.97" height="1744.95" fill="black" fill-opacity="0.429376"/>
</g>
</g>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1481.28 1681.82L1480.61 1669.39C1480.3 1663.59 1480.15 1659.52 1480.15 1657.17H1480.07C1478.78 1661.31 1477.59 1664.89 1476.5 1667.92L1471.5 1681.65H1468.73L1464.11 1668.17C1462.68 1663.86 1461.6 1660.19 1460.87 1657.17H1460.79C1460.7 1660.78 1460.52 1664.95 1460.24 1669.68L1459.49 1681.82H1456L1457.97 1653.51H1462.64L1467.47 1667.2C1468.59 1670.56 1469.54 1673.74 1470.32 1676.74H1470.41C1471.08 1674.16 1472.09 1670.98 1473.43 1667.2L1478.47 1653.51H1483.13L1484.9 1681.82H1481.28ZM1503.73 1669.35V1676.95C1503.73 1678.91 1503.83 1680.53 1504.02 1681.82H1500.71L1500.41 1679.26H1500.29C1499.67 1680.13 1498.82 1680.85 1497.74 1681.42C1496.67 1682 1495.44 1682.28 1494.07 1682.28C1492.11 1682.28 1490.58 1681.71 1489.49 1680.56C1488.4 1679.41 1487.85 1678.04 1487.85 1676.44C1487.85 1673.98 1488.91 1672.1 1491.03 1670.79C1493.14 1669.49 1496.16 1668.86 1500.08 1668.88V1668.46C1500.08 1667.96 1500.03 1667.48 1499.93 1667.01C1499.83 1666.55 1499.64 1666.06 1499.34 1665.52C1499.05 1664.99 1498.57 1664.57 1497.91 1664.26C1497.25 1663.96 1496.44 1663.8 1495.46 1663.8C1493.38 1663.8 1491.61 1664.31 1490.12 1665.31L1489.28 1662.84C1491.16 1661.66 1493.4 1661.07 1496 1661.07C1498.83 1661.07 1500.82 1661.86 1501.99 1663.42C1503.15 1664.99 1503.73 1666.97 1503.73 1669.35ZM1500.16 1674.97V1671.45C1494.42 1671.33 1491.55 1672.86 1491.55 1676.02C1491.55 1677.17 1491.88 1678.05 1492.54 1678.65C1493.2 1679.25 1494.01 1679.55 1494.99 1679.55C1496.25 1679.55 1497.32 1679.22 1498.19 1678.56C1499.05 1677.91 1499.66 1677.1 1499.99 1676.15C1500.1 1675.79 1500.16 1675.39 1500.16 1674.97ZM1522.35 1678.33L1522.98 1681.11C1521.33 1681.89 1519.39 1682.28 1517.15 1682.28C1514.09 1682.28 1511.64 1681.33 1509.8 1679.43C1507.95 1677.52 1507.02 1675.02 1507.02 1671.91C1507.02 1668.74 1508.02 1666.15 1510.03 1664.12C1512.03 1662.09 1514.67 1661.07 1517.94 1661.07C1520.02 1661.07 1521.72 1661.44 1523.07 1662.16L1522.23 1664.98C1521 1664.33 1519.57 1664.01 1517.94 1664.01C1515.7 1664.01 1513.95 1664.75 1512.67 1666.22C1511.4 1667.69 1510.76 1669.51 1510.76 1671.7C1510.76 1674.02 1511.43 1675.87 1512.76 1677.24C1514.09 1678.61 1515.77 1679.3 1517.82 1679.3C1519.39 1679.3 1520.9 1678.98 1522.35 1678.33ZM1526.24 1681.74V1653.93C1528 1653.51 1530.23 1653.3 1532.91 1653.3C1536.41 1653.3 1538.99 1653.99 1540.64 1655.36C1542.24 1656.54 1543.04 1658.2 1543.04 1660.36C1543.04 1661.73 1542.61 1662.98 1541.75 1664.1C1540.9 1665.22 1539.73 1666.04 1538.25 1666.57V1666.7C1539.82 1667.06 1541.18 1667.85 1542.34 1669.05C1543.51 1670.26 1544.09 1671.82 1544.09 1673.76C1544.09 1676.05 1543.27 1677.94 1541.65 1679.43C1539.77 1681.19 1536.53 1682.07 1531.91 1682.07C1529.75 1682.07 1527.86 1681.96 1526.24 1681.74ZM1529.89 1656.37V1665.52H1533.21C1535.08 1665.52 1536.57 1665.08 1537.66 1664.18C1538.75 1663.28 1539.3 1662.14 1539.3 1660.74C1539.3 1657.66 1537.24 1656.12 1533.12 1656.12C1531.75 1656.12 1530.67 1656.2 1529.89 1656.37ZM1529.89 1668.25V1679.05C1530.56 1679.16 1531.58 1679.22 1532.96 1679.22C1535.06 1679.22 1536.79 1678.78 1538.16 1677.89C1539.54 1677.01 1540.22 1675.62 1540.22 1673.71C1540.22 1671.89 1539.54 1670.53 1538.16 1669.62C1536.79 1668.71 1535.04 1668.25 1532.91 1668.25H1529.89ZM1556.45 1661.07C1559.36 1661.07 1561.72 1662.04 1563.53 1663.97C1565.34 1665.9 1566.24 1668.41 1566.24 1671.49C1566.24 1674.99 1565.23 1677.66 1563.21 1679.51C1561.2 1681.36 1558.83 1682.28 1556.12 1682.28C1553.32 1682.28 1550.99 1681.32 1549.14 1679.4C1547.3 1677.49 1546.37 1674.96 1546.37 1671.82C1546.37 1668.55 1547.33 1665.94 1549.25 1663.99C1551.17 1662.04 1553.57 1661.07 1556.45 1661.07ZM1556.37 1663.84C1554.35 1663.84 1552.81 1664.62 1551.75 1666.18C1550.68 1667.73 1550.15 1669.57 1550.15 1671.7C1550.15 1673.94 1550.73 1675.8 1551.87 1677.28C1553.02 1678.77 1554.49 1679.51 1556.28 1679.51C1558.05 1679.51 1559.52 1678.76 1560.69 1677.26C1561.87 1675.76 1562.46 1673.88 1562.46 1671.61C1562.46 1669.63 1561.95 1667.83 1560.93 1666.24C1559.9 1664.64 1558.38 1663.84 1556.37 1663.84ZM1578.31 1661.07C1581.22 1661.07 1583.58 1662.04 1585.39 1663.97C1587.19 1665.9 1588.1 1668.41 1588.1 1671.49C1588.1 1674.99 1587.09 1677.66 1585.07 1679.51C1583.06 1681.36 1580.69 1682.28 1577.97 1682.28C1575.17 1682.28 1572.85 1681.32 1571 1679.4C1569.15 1677.49 1568.23 1674.96 1568.23 1671.82C1568.23 1668.55 1569.19 1665.94 1571.11 1663.99C1573.03 1662.04 1575.43 1661.07 1578.31 1661.07ZM1578.23 1663.84C1576.21 1663.84 1574.67 1664.62 1573.61 1666.18C1572.54 1667.73 1572.01 1669.57 1572.01 1671.7C1572.01 1673.94 1572.58 1675.8 1573.73 1677.28C1574.88 1678.77 1576.35 1679.51 1578.14 1679.51C1579.91 1679.51 1581.38 1678.76 1582.55 1677.26C1583.73 1675.76 1584.32 1673.88 1584.32 1671.61C1584.32 1669.63 1583.81 1667.83 1582.78 1666.24C1581.76 1664.64 1580.24 1663.84 1578.23 1663.84ZM1595.21 1652V1670.82H1595.3C1595.86 1670.03 1596.44 1669.26 1597.06 1668.51L1603.07 1661.49H1607.48L1599.66 1669.85L1608.61 1681.82H1604.07L1597.1 1672.08L1595.21 1674.18V1681.82H1591.56V1652H1595.21Z" fill="#C4C3C8"/>
<g clip-path="url(#clip1)">
<g filter="url(#filter1_ii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1532 1700H0V1717.1C20.4211 1727.86 109.291 1747.03 205.2 1753.45C301.109 1759.86 436.05 1762 436.05 1762H1532H1539H2629.93C2629.93 1762 2764.26 1759.86 2859.73 1753.45C2955.21 1747.03 3043.67 1727.86 3064 1717.1V1700H1539H1532Z" fill="url(#paint2_linear)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1532 1700H0V1717.1C20.4211 1727.86 109.291 1747.03 205.2 1753.45C301.109 1759.86 436.05 1762 436.05 1762H1532H1539H2629.93C2629.93 1762 2764.26 1759.86 2859.73 1753.45C2955.21 1747.03 3043.67 1727.86 3064 1717.1V1700H1539H1532Z" fill="url(#paint3_linear)" style="mix-blend-mode:overlay"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M1532 1700H0V1717.1C20.4211 1727.86 109.291 1747.03 205.2 1753.45C301.109 1759.86 436.05 1762 436.05 1762H1532H1539H2629.93C2629.93 1762 2764.26 1759.86 2859.73 1753.45C2955.21 1747.03 3043.67 1727.86 3064 1717.1V1700H1539H1532Z" fill="url(#paint4_linear)" fill-opacity="0.43" style="mix-blend-mode:overlay"/>
</g>
<ellipse cx="2765.5" cy="1747.5" rx="16.5" ry="3.5" fill="url(#paint5_linear)"/>
<mask id="mask1" mask-type="alpha" maskUnits="userSpaceOnUse" x="2749" y="1744" width="33" height="7">
<ellipse cx="2765.5" cy="1747.5" rx="16.5" ry="3.5" fill="white"/>
</mask>
<g mask="url(#mask1)">
<g filter="url(#filter2_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M2765 1747C2769.42 1747 2773 1745.43 2773 1743.5C2773 1743.13 2772.87 1742.77 2772.63 1742.44C2770.47 1742.16 2768.05 1742 2765.5 1742C2762.5 1742 2759.69 1742.22 2757.27 1742.6C2757.09 1742.89 2757 1743.19 2757 1743.5C2757 1745.43 2760.58 1747 2765 1747Z" fill="#141823"/>
</g>
</g>
<ellipse cx="1908.5" cy="1747.5" rx="16.5" ry="3.5" fill="url(#paint6_linear)"/>
<mask id="mask2" mask-type="alpha" maskUnits="userSpaceOnUse" x="1892" y="1744" width="33" height="7">
<ellipse cx="1908.5" cy="1747.5" rx="16.5" ry="3.5" fill="white"/>
</mask>
<g mask="url(#mask2)">
<g filter="url(#filter3_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1908 1747C1912.42 1747 1916 1745.43 1916 1743.5C1916 1743.13 1915.87 1742.77 1915.63 1742.44C1913.47 1742.16 1911.05 1742 1908.5 1742C1905.5 1742 1902.69 1742.22 1900.27 1742.6C1900.09 1742.89 1900 1743.19 1900 1743.5C1900 1745.43 1903.58 1747 1908 1747Z" fill="#141823"/>
</g>
</g>
<ellipse cx="1152.5" cy="1747.5" rx="16.5" ry="3.5" fill="url(#paint7_linear)"/>
<mask id="mask3" mask-type="alpha" maskUnits="userSpaceOnUse" x="1136" y="1744" width="33" height="7">
<ellipse cx="1152.5" cy="1747.5" rx="16.5" ry="3.5" fill="white"/>
</mask>
<g mask="url(#mask3)">
<g filter="url(#filter4_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1152 1747C1156.42 1747 1160 1745.43 1160 1743.5C1160 1743.13 1159.87 1742.77 1159.63 1742.44C1157.47 1742.16 1155.05 1742 1152.5 1742C1149.5 1742 1146.69 1742.22 1144.27 1742.6C1144.09 1742.89 1144 1743.19 1144 1743.5C1144 1745.43 1147.58 1747 1152 1747Z" fill="#141823"/>
</g>
</g>
<ellipse cx="302.5" cy="1747.5" rx="16.5" ry="3.5" fill="url(#paint8_linear)"/>
<mask id="mask4" mask-type="alpha" maskUnits="userSpaceOnUse" x="286" y="1744" width="33" height="7">
<ellipse cx="302.5" cy="1747.5" rx="16.5" ry="3.5" fill="white"/>
</mask>
<g mask="url(#mask4)">
<g filter="url(#filter5_f)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M302 1747C306.418 1747 310 1745.43 310 1743.5C310 1743.13 309.869 1742.77 309.627 1742.44C307.469 1742.16 305.052 1742 302.5 1742C299.502 1742 296.69 1742.22 294.267 1742.6C294.093 1742.89 294 1743.19 294 1743.5C294 1745.43 297.582 1747 302 1747Z" fill="#141823"/>
</g>
</g>
<g filter="url(#filter6_di)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M1823 1712.96C1753.29 1718.49 1649.46 1722 1533.49 1722C1415.86 1722 1310.71 1718.39 1241 1712.72V1700H1823V1712.96Z" fill="url(#paint9_linear)"/>
</g>
<g filter="url(#filter7_d)">
<rect y="1700" width="1241" height="16" fill="url(#paint10_linear)"/>
<rect width="1241" height="16" transform="matrix(-1 0 0 1 3064 1700)" fill="url(#paint11_linear)"/>
</g>
</g>
<rect x="380" y="128" width="2304" height="1440" fill="#1D2129"/>
<rect x="380" y="128" width="2304" height="1440" fill="url(#paint12_linear)"/>
<g clip-path="url(#clip2)">
<g filter="url(#filter8_ddd)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M642.031 316C638.148 316 635 319.148 635 323.031V1373.58C635 1377.46 638.148 1380.61 642.031 1380.61H2415.94C2419.82 1380.61 2422.97 1377.46 2422.97 1373.58V323.031C2422.97 319.148 2419.82 316 2415.94 316H642.031Z" fill="#ECECEC"/>
</g>
<g clip-path="url(#clip3)">
<g filter="url(#filter9_ii)">
<path d="M635 323.031C635 319.148 638.148 316 642.031 316H2415.94C2419.82 316 2422.97 319.148 2422.97 323.031V346.936H635V323.031Z" fill="url(#paint13_linear)"/>
</g>
<circle cx="654.687" cy="331.468" r="8.08552" fill="#FF5F58" stroke="#E1483F" stroke-width="0.703089"/>
<circle cx="682.811" cy="331.468" r="8.08552" fill="#D1D1D1" stroke="#B1B1B1" stroke-width="0.703089"/>
<circle cx="710.934" cy="331.468" r="8.08552" fill="#D1D1D1" stroke="#B1B1B1" stroke-width="0.703089"/>
</g>


</g>
<g clip-path="url(#clip4)">
<g filter="url(#filter10_bdd)">
<rect x="380" y="128.155" width="2304.14" height="27.9703" fill="#FAFAFA" fill-opacity="0.8"/>
</g>
<g clip-path="url(#clip5)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M2636.53 135.766H2634V138.302H2636.53V135.766ZM2656.83 135.766H2639.07V138.302H2656.83V135.766ZM2633.99 140.839H2636.53V143.376H2633.99V140.839ZM2653.02 140.839H2639.07V143.376H2653.02V140.839ZM2633.99 145.913H2636.53V148.45H2633.99V145.913ZM2656.83 145.913H2639.07V148.45H2656.83V145.913Z" fill="black" fill-opacity="0.75"/>
<g opacity="0.8">
<circle cx="2602.92" cy="140.205" r="6.02479" stroke="black" stroke-width="1.90257"/>
<path d="M2613.07 150.352L2607.36 144.644" stroke="black" stroke-width="1.90257" stroke-linecap="round" stroke-linejoin="round"/>
</g>
<g opacity="0.8">
<path d="M2498.09 135.497L2502.22 145.797L2506.35 135.497H2508.5V148.121H2506.84V143.205L2507 137.899L2502.85 148.121H2501.58L2497.44 137.925L2497.61 143.205V148.121H2495.94V135.497H2498.09Z" fill="black"/>
<path d="M2510.46 143.344C2510.46 142.425 2510.64 141.598 2511 140.864C2511.36 140.13 2511.87 139.563 2512.51 139.164C2513.16 138.766 2513.89 138.566 2514.72 138.566C2516 138.566 2517.03 139.008 2517.82 139.893C2518.61 140.777 2519 141.953 2519 143.422V143.534C2519 144.448 2518.83 145.268 2518.47 145.997C2518.13 146.719 2517.63 147.283 2516.97 147.688C2516.33 148.092 2515.58 148.295 2514.74 148.295C2513.47 148.295 2512.43 147.852 2511.64 146.968C2510.86 146.084 2510.46 144.913 2510.46 143.456V143.344ZM2512.08 143.534C2512.08 144.575 2512.32 145.41 2512.8 146.04C2513.28 146.67 2513.93 146.985 2514.74 146.985C2515.55 146.985 2516.2 146.667 2516.68 146.031C2517.16 145.39 2517.4 144.494 2517.4 143.344C2517.4 142.315 2517.15 141.482 2516.66 140.847C2516.18 140.205 2515.53 139.884 2514.72 139.884C2513.93 139.884 2513.29 140.199 2512.8 140.829C2512.32 141.459 2512.08 142.361 2512.08 143.534Z" fill="black"/>
<path d="M2520.74 147.28C2520.74 147.003 2520.83 146.771 2520.99 146.586C2521.16 146.401 2521.4 146.309 2521.73 146.309C2522.06 146.309 2522.31 146.401 2522.48 146.586C2522.65 146.771 2522.74 147.003 2522.74 147.28C2522.74 147.546 2522.65 147.768 2522.48 147.948C2522.31 148.127 2522.06 148.216 2521.73 148.216C2521.4 148.216 2521.16 148.127 2520.99 147.948C2520.83 147.768 2520.74 147.546 2520.74 147.28Z" fill="black"/>
<path d="M2536.94 142.737C2536.94 144.615 2536.62 146.011 2535.98 146.925C2535.34 147.838 2534.33 148.295 2532.97 148.295C2531.62 148.295 2530.62 147.849 2529.98 146.959C2529.33 146.063 2528.99 144.728 2528.97 142.953V140.812C2528.97 138.956 2529.29 137.578 2529.93 136.676C2530.58 135.774 2531.58 135.323 2532.95 135.323C2534.31 135.323 2535.31 135.76 2535.95 136.633C2536.59 137.5 2536.92 138.841 2536.94 140.656V142.737ZM2535.34 140.543C2535.34 139.185 2535.14 138.196 2534.76 137.578C2534.38 136.953 2533.78 136.641 2532.95 136.641C2532.13 136.641 2531.53 136.951 2531.16 137.569C2530.78 138.188 2530.59 139.138 2530.58 140.422V142.988C2530.58 144.352 2530.77 145.361 2531.17 146.014C2531.56 146.662 2532.17 146.985 2532.97 146.985C2533.76 146.985 2534.35 146.679 2534.73 146.066C2535.12 145.453 2535.32 144.488 2535.34 143.17V140.543Z" fill="black"/>
<path d="M2544.84 142.572C2544.5 142.971 2544.1 143.292 2543.63 143.534C2543.17 143.777 2542.66 143.899 2542.11 143.899C2541.38 143.899 2540.74 143.719 2540.2 143.361C2539.66 143.003 2539.25 142.5 2538.95 141.852C2538.66 141.199 2538.51 140.479 2538.51 139.693C2538.51 138.849 2538.67 138.089 2538.99 137.413C2539.31 136.737 2539.77 136.219 2540.35 135.861C2540.94 135.503 2541.63 135.323 2542.42 135.323C2543.67 135.323 2544.65 135.792 2545.37 136.728C2546.09 137.659 2546.45 138.93 2546.45 140.543V141.011C2546.45 143.468 2545.96 145.263 2544.99 146.396C2544.02 147.523 2542.56 148.101 2540.6 148.13H2540.29V146.777H2540.62C2541.95 146.754 2542.96 146.41 2543.68 145.745C2544.39 145.075 2544.77 144.017 2544.84 142.572ZM2542.37 142.572C2542.9 142.572 2543.4 142.407 2543.85 142.078C2544.31 141.748 2544.64 141.341 2544.85 140.855V140.214C2544.85 139.162 2544.62 138.306 2544.16 137.647C2543.7 136.988 2543.13 136.659 2542.43 136.659C2541.72 136.659 2541.16 136.93 2540.73 137.474C2540.3 138.011 2540.09 138.722 2540.09 139.607C2540.09 140.468 2540.29 141.179 2540.7 141.74C2541.12 142.294 2541.67 142.572 2542.37 142.572Z" fill="black"/>
<path d="M2548.47 147.28C2548.47 147.003 2548.55 146.771 2548.71 146.586C2548.88 146.401 2549.13 146.309 2549.46 146.309C2549.79 146.309 2550.04 146.401 2550.2 146.586C2550.38 146.771 2550.46 147.003 2550.46 147.28C2550.46 147.546 2550.38 147.768 2550.2 147.948C2550.04 148.127 2549.79 148.216 2549.46 148.216C2549.13 148.216 2548.88 148.127 2548.71 147.948C2548.55 147.768 2548.47 147.546 2548.47 147.28ZM2548.48 139.624C2548.48 139.346 2548.56 139.115 2548.72 138.93C2548.89 138.745 2549.14 138.653 2549.47 138.653C2549.8 138.653 2550.04 138.745 2550.21 138.93C2550.39 139.115 2550.47 139.346 2550.47 139.624C2550.47 139.89 2550.39 140.112 2550.21 140.292C2550.04 140.471 2549.8 140.56 2549.47 140.56C2549.14 140.56 2548.89 140.471 2548.72 140.292C2548.56 140.112 2548.48 139.89 2548.48 139.624Z" fill="black"/>
<path d="M2559.12 143.881H2560.88V145.19H2559.12V148.121H2557.51V145.19H2551.76V144.245L2557.42 135.497H2559.12V143.881ZM2553.58 143.881H2557.51V137.69L2557.32 138.037L2553.58 143.881Z" fill="black"/>
<path d="M2567.29 148.121H2565.68V137.43L2562.44 138.618V137.162L2567.04 135.436H2567.29V148.121Z" fill="black"/>
</g>
<g opacity="0.8">
<path fill-rule="evenodd" clip-rule="evenodd" d="M2456.42 139.571C2456.42 138.87 2456.99 138.302 2457.69 138.302H2461.5L2466.57 134.497V149.718L2461.5 145.913H2457.69C2456.99 145.913 2456.42 145.345 2456.42 144.644V139.571Z" fill="black"/>
<path d="M2473.94 148.449C2475.54 146.733 2476.53 144.4 2476.53 141.83C2476.53 139.22 2475.51 136.855 2473.86 135.131" stroke="black" stroke-width="1.26838" stroke-linecap="round"/>
<path d="M2469.74 146.547C2470.91 145.41 2471.64 143.822 2471.64 142.064C2471.64 140.351 2470.95 138.798 2469.83 137.668" stroke="black" stroke-width="1.26838" stroke-linecap="round"/>
</g>
<path d="M2442.65 138.107C2439.94 135.084 2436.29 133.229 2432.27 133.229C2428.22 133.229 2424.54 135.109 2421.84 138.168" stroke="black" stroke-width="1.52205" stroke-linecap="square"/>
<path d="M2439.64 141.742C2437.71 139.609 2435.12 138.302 2432.27 138.302C2429.42 138.302 2426.83 139.603 2424.91 141.728" stroke="black" stroke-width="1.52205" stroke-linecap="square"/>
<path d="M2436.58 145.318C2435.44 144.11 2433.93 143.376 2432.27 143.376C2430.63 143.376 2429.13 144.098 2427.99 145.287" stroke="black" stroke-width="1.52205" stroke-linecap="square"/>
<ellipse cx="2432.25" cy="149.401" rx="2.1484" ry="1.58547" fill="black"/>
</g>
<g clip-path="url(#clip6)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M417.858 133.877C418.635 133.033 419.062 131.874 418.995 130.692C417.937 130.692 416.71 131.311 415.933 132.223C415.325 132.977 414.673 134.159 414.909 135.341C416.001 135.476 417.183 134.789 417.858 133.877ZM418.894 135.599C417.251 135.599 415.799 136.511 415.022 136.511C414.212 136.511 413.03 135.554 411.702 135.599C409.969 135.633 408.382 136.657 407.492 138.166C406.862 139.246 406.614 140.518 406.637 141.813C406.671 144.255 407.627 146.799 408.753 148.42C409.62 149.658 410.599 150.986 411.983 150.986C413.233 150.986 413.694 150.153 415.326 150.153C416.846 150.153 417.319 150.986 418.635 150.986C420.02 150.986 420.932 149.725 421.753 148.476C422.789 147.024 423.138 145.64 423.183 145.583C423.138 145.583 420.526 144.525 420.425 141.509C420.425 138.864 422.575 137.67 422.665 137.614C421.494 135.813 419.603 135.599 418.894 135.599Z" fill="#474747"/>
<path d="M457.551 142.696H452.47V148.045H450.277V135.421H458.297V137.19H452.47V140.944H457.551V142.696Z" fill="#484848"/>
<path d="M461.773 148.045H459.666V138.664H461.773V148.045ZM459.536 136.227C459.536 135.904 459.637 135.635 459.839 135.421C460.047 135.207 460.342 135.1 460.724 135.1C461.105 135.1 461.4 135.207 461.608 135.421C461.816 135.635 461.92 135.904 461.92 136.227C461.92 136.545 461.816 136.811 461.608 137.025C461.4 137.233 461.105 137.337 460.724 137.337C460.342 137.337 460.047 137.233 459.839 137.025C459.637 136.811 459.536 136.545 459.536 136.227Z" fill="#484848"/>
<path d="M466.012 148.045H463.905V134.727H466.012V148.045Z" fill="#484848"/>
<path d="M472.141 148.219C470.806 148.219 469.722 147.8 468.889 146.961C468.063 146.118 467.65 144.996 467.65 143.597V143.337C467.65 142.401 467.829 141.565 468.187 140.831C468.551 140.091 469.06 139.516 469.713 139.106C470.366 138.696 471.095 138.49 471.898 138.49C473.176 138.49 474.161 138.898 474.855 139.713C475.554 140.528 475.904 141.681 475.904 143.172V144.022H469.774C469.837 144.797 470.095 145.409 470.546 145.86C471.002 146.311 471.574 146.537 472.262 146.537C473.228 146.537 474.014 146.146 474.621 145.366L475.757 146.45C475.381 147.011 474.878 147.447 474.248 147.759C473.624 148.065 472.921 148.219 472.141 148.219ZM471.889 140.181C471.311 140.181 470.843 140.383 470.485 140.788C470.132 141.193 469.907 141.756 469.809 142.479H473.823V142.323C473.777 141.617 473.589 141.086 473.259 140.727C472.93 140.363 472.473 140.181 471.889 140.181Z" fill="#484848"/>
<path d="M505.413 142.409H500.228V146.294H506.289V148.045H498.034V135.421H506.228V137.19H500.228V140.675H505.413V142.409Z" fill="#484848"/>
<path d="M506.999 143.285C506.999 141.84 507.334 140.681 508.004 139.808C508.675 138.93 509.574 138.49 510.701 138.49C511.695 138.49 512.499 138.837 513.111 139.531V134.727H515.218V148.045H513.311L513.207 147.074C512.577 147.837 511.736 148.219 510.684 148.219C509.585 148.219 508.695 147.776 508.013 146.892C507.337 146.008 506.999 144.805 506.999 143.285ZM509.106 143.467C509.106 144.421 509.288 145.167 509.652 145.704C510.022 146.236 510.545 146.502 511.221 146.502C512.082 146.502 512.713 146.118 513.111 145.349V141.343C512.724 140.591 512.1 140.216 511.239 140.216C510.556 140.216 510.03 140.487 509.66 141.031C509.291 141.568 509.106 142.381 509.106 143.467Z" fill="#484848"/>
<path d="M519.353 148.045H517.246V138.664H519.353V148.045ZM517.116 136.227C517.116 135.904 517.217 135.635 517.42 135.421C517.628 135.207 517.923 135.1 518.304 135.1C518.686 135.1 518.98 135.207 519.188 135.421C519.397 135.635 519.501 135.904 519.501 136.227C519.501 136.545 519.397 136.811 519.188 137.025C518.98 137.233 518.686 137.337 518.304 137.337C517.923 137.337 517.628 137.233 517.42 137.025C517.217 136.811 517.116 136.545 517.116 136.227Z" fill="#484848"/>
<path d="M523.991 136.383V138.664H525.647V140.224H523.991V145.461C523.991 145.82 524.06 146.08 524.199 146.242C524.344 146.398 524.598 146.476 524.962 146.476C525.205 146.476 525.451 146.447 525.699 146.389V148.019C525.219 148.152 524.757 148.219 524.312 148.219C522.693 148.219 521.884 147.326 521.884 145.539V140.224H520.341V138.664H521.884V136.383H523.991Z" fill="#484848"/>
<path d="M552.199 145.297L555.407 135.421H557.818L553.274 148.045H551.15L546.624 135.421H549.026L552.199 145.297Z" fill="#484848"/>
<path d="M560.982 148.045H558.875V138.664H560.982V148.045ZM558.745 136.227C558.745 135.904 558.846 135.635 559.048 135.421C559.256 135.207 559.551 135.1 559.933 135.1C560.314 135.1 560.609 135.207 560.817 135.421C561.025 135.635 561.129 135.904 561.129 136.227C561.129 136.545 561.025 136.811 560.817 137.025C560.609 137.233 560.314 137.337 559.933 137.337C559.551 137.337 559.256 137.233 559.048 137.025C558.846 136.811 558.745 136.545 558.745 136.227Z" fill="#484848"/>
<path d="M567.111 148.219C565.776 148.219 564.692 147.8 563.859 146.961C563.033 146.118 562.619 144.996 562.619 143.597V143.337C562.619 142.401 562.799 141.565 563.157 140.831C563.521 140.091 564.03 139.516 564.683 139.106C565.336 138.696 566.065 138.49 566.868 138.49C568.146 138.49 569.131 138.898 569.825 139.713C570.524 140.528 570.874 141.681 570.874 143.172V144.022H564.744C564.807 144.797 565.065 145.409 565.515 145.86C565.972 146.311 566.544 146.537 567.232 146.537C568.198 146.537 568.984 146.146 569.591 145.366L570.726 146.45C570.351 147.011 569.848 147.447 569.218 147.759C568.593 148.065 567.891 148.219 567.111 148.219ZM566.859 140.181C566.281 140.181 565.813 140.383 565.455 140.788C565.102 141.193 564.877 141.756 564.778 142.479H568.793V142.323C568.747 141.617 568.559 141.086 568.229 140.727C567.9 140.363 567.443 140.181 566.859 140.181Z" fill="#484848"/>
<path d="M580.454 145.141L581.945 138.664H584L581.442 148.045H579.708L577.697 141.603L575.72 148.045H573.986L571.419 138.664H573.474L574.991 145.071L576.916 138.664H578.503L580.454 145.141Z" fill="#484848"/>
<path d="M615.798 144.924L617.74 135.421H619.917L617.003 148.045H614.905L612.503 138.828L610.049 148.045H607.943L605.029 135.421H607.206L609.165 144.907L611.576 135.421H613.414L615.798 144.924Z" fill="#484848"/>
<path d="M623.254 148.045H621.147V138.664H623.254V148.045ZM621.017 136.227C621.017 135.904 621.118 135.635 621.32 135.421C621.528 135.207 621.823 135.1 622.205 135.1C622.586 135.1 622.881 135.207 623.089 135.421C623.297 135.635 623.401 135.904 623.401 136.227C623.401 136.545 623.297 136.811 623.089 137.025C622.881 137.233 622.586 137.337 622.205 137.337C621.823 137.337 621.528 137.233 621.32 137.025C621.118 136.811 621.017 136.545 621.017 136.227Z" fill="#484848"/>
<path d="M627.207 138.664L627.267 139.748C627.961 138.909 628.871 138.49 629.999 138.49C631.952 138.49 632.947 139.609 632.981 141.846V148.045H630.874V141.967C630.874 141.372 630.744 140.933 630.484 140.649C630.23 140.36 629.811 140.216 629.227 140.216C628.377 140.216 627.744 140.6 627.328 141.369V148.045H625.221V138.664H627.207Z" fill="#484848"/>
<path d="M634.437 143.285C634.437 141.84 634.772 140.681 635.443 139.808C636.113 138.93 637.012 138.49 638.139 138.49C639.133 138.49 639.937 138.837 640.55 139.531V134.727H642.657V148.045H640.749L640.645 147.074C640.015 147.837 639.174 148.219 638.122 148.219C637.024 148.219 636.133 147.776 635.451 146.892C634.775 146.008 634.437 144.805 634.437 143.285ZM636.544 143.467C636.544 144.421 636.726 145.167 637.09 145.704C637.46 146.236 637.983 146.502 638.659 146.502C639.521 146.502 640.151 146.118 640.55 145.349V141.343C640.162 140.591 639.538 140.216 638.677 140.216C637.995 140.216 637.469 140.487 637.099 141.031C636.729 141.568 636.544 142.381 636.544 143.467Z" fill="#484848"/>
<path d="M644.156 143.268C644.156 142.349 644.338 141.522 644.702 140.788C645.066 140.048 645.578 139.482 646.237 139.089C646.896 138.69 647.653 138.49 648.508 138.49C649.774 138.49 650.8 138.898 651.586 139.713C652.378 140.528 652.806 141.609 652.87 142.956L652.878 143.45C652.878 144.375 652.699 145.201 652.341 145.93C651.988 146.658 651.479 147.222 650.815 147.62C650.156 148.019 649.393 148.219 648.526 148.219C647.202 148.219 646.141 147.779 645.344 146.901C644.552 146.016 644.156 144.84 644.156 143.372V143.268ZM646.263 143.45C646.263 144.415 646.462 145.172 646.861 145.722C647.26 146.265 647.815 146.537 648.526 146.537C649.237 146.537 649.789 146.259 650.182 145.704C650.581 145.149 650.78 144.337 650.78 143.268C650.78 142.32 650.575 141.568 650.164 141.013C649.76 140.459 649.208 140.181 648.508 140.181C647.82 140.181 647.274 140.456 646.87 141.005C646.465 141.548 646.263 142.363 646.263 143.45Z" fill="#484848"/>
<path d="M662.597 145.141L664.088 138.664H666.143L663.585 148.045H661.851L659.84 141.603L657.863 148.045H656.129L653.562 138.664H655.617L657.135 145.071L659.059 138.664H660.646L662.597 145.141Z" fill="#484848"/>
<path d="M698.063 148.045H695.878V142.435H690.233V148.045H688.039V135.421H690.233V140.675H695.878V135.421H698.063V148.045Z" fill="#484848"/>
<path d="M704.287 148.219C702.952 148.219 701.868 147.8 701.036 146.961C700.209 146.118 699.796 144.996 699.796 143.597V143.337C699.796 142.401 699.975 141.565 700.333 140.831C700.697 140.091 701.206 139.516 701.859 139.106C702.512 138.696 703.241 138.49 704.044 138.49C705.322 138.49 706.307 138.898 707.001 139.713C707.7 140.528 708.05 141.681 708.05 143.172V144.022H701.92C701.984 144.797 702.241 145.409 702.692 145.86C703.148 146.311 703.721 146.537 704.408 146.537C705.374 146.537 706.16 146.146 706.767 145.366L707.903 146.45C707.527 147.011 707.024 147.447 706.394 147.759C705.77 148.065 705.067 148.219 704.287 148.219ZM704.036 140.181C703.458 140.181 702.989 140.383 702.631 140.788C702.278 141.193 702.053 141.756 701.955 142.479H705.969V142.323C705.923 141.617 705.735 141.086 705.406 140.727C705.076 140.363 704.619 140.181 704.036 140.181Z" fill="#484848"/>
<path d="M711.63 148.045H709.523V134.727H711.63V148.045Z" fill="#484848"/>
<path d="M721.843 143.45C721.843 144.901 721.514 146.06 720.855 146.927C720.196 147.788 719.311 148.219 718.201 148.219C717.173 148.219 716.349 147.881 715.73 147.204V151.652H713.623V138.664H715.566L715.652 139.617C716.271 138.866 717.112 138.49 718.175 138.49C719.32 138.49 720.216 138.918 720.863 139.774C721.516 140.623 721.843 141.805 721.843 143.32V143.45ZM719.745 143.268C719.745 142.331 719.557 141.589 719.181 141.039C718.811 140.49 718.279 140.216 717.586 140.216C716.725 140.216 716.106 140.571 715.73 141.282V145.444C716.112 146.172 716.736 146.537 717.603 146.537C718.274 146.537 718.797 146.268 719.173 145.73C719.554 145.187 719.745 144.366 719.745 143.268Z" fill="#484848"/>
</g>
</g>

</svg>
''',
    frameSize: Size(3064.0, 1780.0),
    screenSize: Size(1422.0, 822.0),
  ),
  DeviceInfo(
    identifier: const DeviceIdentifier._(
      TargetPlatform.android,
      DeviceType.phone,
      'samsung-note10plus',
    ),
    name: 'Samsung Galaxy Note 10 Plus',
    pixelRatio: 3.0,
    safeAreas: EdgeInsets.only(
      left: 0.0,
      top: 48.0,
      right: 0.0,
      bottom: 0.0,
    ),
    rotatedSafeAreas: EdgeInsets.only(
      left: 48.0,
      top: 24.0,
      right: 48.0,
      bottom: 0.0,
    ),
    screenPath: parseSvgPathData(
        'M838.106 25.709H73.1248C21.6723 25.709 21.6757 32.3857 21.6966 74.4971C21.6971 75.3618 21.6975 76.2416 21.6975 77.1365V1806.39C21.6975 1807.28 21.6971 1808.16 21.6966 1809.03C21.6757 1851.14 21.6723 1857.81 73.1248 1857.81H838.106C889.558 1857.81 889.555 1851.14 889.534 1809.03C889.533 1808.16 889.533 1807.28 889.533 1806.39V77.1365C889.533 76.2415 889.533 75.3618 889.534 74.497C889.555 32.3857 889.558 25.709 838.106 25.709ZM455.615 96.8234C469.262 96.8234 480.324 85.7606 480.324 72.1141C480.324 58.4675 469.262 47.4048 455.615 47.4048C441.969 47.4048 430.906 58.4675 430.906 72.1141C430.906 85.7606 441.969 96.8234 455.615 96.8234Z')
      ..fillType = PathFillType.evenOdd,
    svgFrame:
        '''<svg width="907" height="1901" viewBox="0 0 907 1901" fill="none" xmlns="http://www.w3.org/2000/svg"><defs>
<filter id="filter0_iiiiiiii" x="6.02686" y="-1.41066" width="899.177" height="1903.82" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-1.808"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.372741 0 0 0 0 0.372741 0 0 0 0 0.372741 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="1.808"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.372741 0 0 0 0 0.372741 0 0 0 0 0.372741 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4.82133"/>
<feGaussianBlur stdDeviation="1.20533"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-4.82133"/>
<feGaussianBlur stdDeviation="1.20533"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="2.41066"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.752941 0 0 0 0 0.756863 0 0 0 0 0.709804 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect4_innerShadow" result="effect5_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-2.41066"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.752941 0 0 0 0 0.756863 0 0 0 0 0.709804 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect5_innerShadow" result="effect6_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="0.602666"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.301961 0 0 0 0 0.341176 0 0 0 0 0.317647 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect6_innerShadow" result="effect7_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-0.602666"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.301961 0 0 0 0 0.341176 0 0 0 0 0.317647 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect7_innerShadow" result="effect8_innerShadow"/>
</filter>
<filter id="filter1_iiii" x="0" y="345.122" width="6.62932" height="224.794" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="2.41066"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.545098 0 0 0 0 0.541176 0 0 0 0 0.564706 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.602666" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="2.41066"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.545098 0 0 0 0 0.541176 0 0 0 0 0.564706 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.602666" operator="erode" in="SourceAlpha" result="effect3_innerShadow"/>
<feOffset dy="-2.41066"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.545098 0 0 0 0 0.541176 0 0 0 0 0.564706 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.602666" operator="erode" in="SourceAlpha" result="effect4_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.301333"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.853572 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter2_iiii" x="0" y="683.821" width="6.62932" height="119.328" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="2.41066"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.545098 0 0 0 0 0.541176 0 0 0 0 0.564706 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.602666" operator="erode" in="SourceAlpha" result="effect2_innerShadow"/>
<feOffset dy="2.41066"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.545098 0 0 0 0 0.541176 0 0 0 0 0.564706 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.602666" operator="erode" in="SourceAlpha" result="effect3_innerShadow"/>
<feOffset dy="-2.41066"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.545098 0 0 0 0 0.541176 0 0 0 0 0.564706 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feMorphology radius="0.602666" operator="erode" in="SourceAlpha" result="effect4_innerShadow"/>
<feOffset/>
<feGaussianBlur stdDeviation="0.301333"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.853572 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
</filter>
<filter id="filter3_ddddd" x="10.848" y="11.2454" width="890.137" height="1878.51" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.8 0 0 0 0 0.8 0 0 0 0 0.8 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.8 0 0 0 0 0.8 0 0 0 0 0.8 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feColorMatrix type="matrix" values="0 0 0 0 0.67451 0 0 0 0 0.678431 0 0 0 0 0.662745 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect2_dropShadow" result="effect3_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0"/>
<feBlend mode="normal" in2="effect3_dropShadow" result="effect4_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.50167 0"/>
<feBlend mode="normal" in2="effect4_dropShadow" result="effect5_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect5_dropShadow" result="shape"/>
</filter>
<filter id="filter4_iiiii" x="8.43735" y="9.43735" width="894.959" height="1882.13" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-4.21866"/>
<feGaussianBlur stdDeviation="1.50666"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="4.21866"/>
<feGaussianBlur stdDeviation="1.50666"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="7.83466"/>
<feGaussianBlur stdDeviation="1.50666"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-7.83466"/>
<feGaussianBlur stdDeviation="1.50666"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset/>
<feGaussianBlur stdDeviation="2.41066"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect4_innerShadow" result="effect5_innerShadow"/>
</filter>
<filter id="filter5_d" x="439.344" y="55.2401" width="32.544" height="33.1466" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dy="-0.602666"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.09 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter6_d" x="446.575" y="64.2798" width="16.8746" height="16.8746" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="-0.602666" dy="0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.213315 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow" result="shape"/>
</filter>
<filter id="filter7_f" x="432.898" y="50.1609" width="36.6962" height="31.4921" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="4.45595" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter8_f" x="447.695" y="64.8277" width="8.72809" height="7.85412" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="1.11399" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter9_f" x="448.147" y="66.9195" width="28.9784" height="20.756" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="2.22797" result="effect1_foregroundBlur"/>
</filter>
<filter id="filter10_dd" x="317.003" y="0.397334" width="14.464" height="12.0533" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.116112 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="-0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.116112 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
</filter>
<filter id="filter11_dd" x="4.82152" y="116.109" width="6.62932" height="19.888" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.116112 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="-0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.116112 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
</filter>
<filter id="filter12_dd" x="899.78" y="116.109" width="6.62932" height="19.888" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.116112 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="-0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.116112 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
</filter>
<filter id="filter13_dd" x="152.475" y="1889.75" width="19.888" height="10.2453" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.116112 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="-0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.116112 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
</filter>
<filter id="filter14_dd" x="738.266" y="1890.36" width="19.888" height="10.2453" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.116112 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"/>
<feOffset dx="-0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.116112 0"/>
<feBlend mode="normal" in2="effect1_dropShadow" result="effect2_dropShadow"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow" result="shape"/>
</filter>
<filter id="filter15_i" x="294.704" y="11.8481" width="321.631" height="7.23199" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="1.808"/>
<feGaussianBlur stdDeviation="0.903999"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter16_i" x="296.296" y="14.9473" width="319.844" height="2.92745" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="0.602666" dy="0.602666"/>
<feGaussianBlur stdDeviation="0.301333"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.35 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter17_i" x="294.704" y="11.8481" width="321.631" height="5.42399" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-0.602666"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0.380607 0 0 0 0 0.380607 0 0 0 0 0.380607 0 0 0 1 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
</filter>
<filter id="filter18_iiiiii" x="2.4107" y="9.43735" width="907.012" height="1882.13" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-10.2453"/>
<feGaussianBlur stdDeviation="4.51999"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.8 0"/>
<feBlend mode="normal" in2="shape" result="effect1_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="10.2453"/>
<feGaussianBlur stdDeviation="4.51999"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.803612 0"/>
<feBlend mode="normal" in2="effect1_innerShadow" result="effect2_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="-4.21866"/>
<feGaussianBlur stdDeviation="1.50666"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect2_innerShadow" result="effect3_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dx="4.21866"/>
<feGaussianBlur stdDeviation="1.50666"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect3_innerShadow" result="effect4_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="7.83466"/>
<feGaussianBlur stdDeviation="1.50666"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect4_innerShadow" result="effect5_innerShadow"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="-7.83466"/>
<feGaussianBlur stdDeviation="1.50666"/>
<feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0"/>
<feBlend mode="normal" in2="effect5_innerShadow" result="effect6_innerShadow"/>
</filter>
<radialGradient id="paint0_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(894.382 7.02313) rotate(90) scale(63.7213 30.1721)">
<stop stop-opacity="0.954455"/>
<stop offset="1" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint1_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(16.8101 -7.64174) rotate(90) scale(83.5745 39.5726)">
<stop stop-opacity="0.698256"/>
<stop offset="1" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint2_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(879.317 1933.48) rotate(90) scale(83.5745 39.5726)">
<stop stop-opacity="0.698256"/>
<stop offset="1" stop-opacity="0.01"/>
</radialGradient>
<radialGradient id="paint3_radial" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(28.216 1913.57) rotate(90) scale(83.5745 39.5726)">
<stop stop-opacity="0.698256"/>
<stop offset="1" stop-opacity="0.01"/>
</radialGradient>
<linearGradient id="paint4_linear" x1="1.52003" y1="521.467" x2="5.33264" y2="521.467" gradientUnits="userSpaceOnUse">
<stop offset="0.0285405" stop-color="#383838"/>
<stop offset="0.592779" stop-color="#5E5E5E"/>
<stop offset="0.979475" stop-color="#585858"/>
</linearGradient>
<linearGradient id="paint5_linear" x1="1.52003" y1="777.105" x2="5.33264" y2="777.105" gradientUnits="userSpaceOnUse">
<stop offset="0.0285405" stop-color="#383838"/>
<stop offset="0.592779" stop-color="#5E5E5E"/>
<stop offset="0.979475" stop-color="#585858"/>
</linearGradient>
<linearGradient id="paint6_linear" x1="437.203" y1="71.1302" x2="455.703" y2="89.8102" gradientUnits="userSpaceOnUse">
<stop stop-color="#191721"/>
<stop offset="1" stop-color="#3D3947"/>
</linearGradient>
<linearGradient id="paint7_linear" x1="11.976" y1="10.7089" x2="11.976" y2="1.21318e-05" gradientUnits="userSpaceOnUse">
<stop stop-color="#6E6F6F"/>
<stop offset="0.247674" stop-color="#C3C3C3"/>
<stop offset="0.705564" stop-color="#717171"/>
<stop offset="1" stop-color="#373737"/>
</linearGradient>
<linearGradient id="paint8_linear" x1="6.0539" y1="135.155" x2="10.2185" y2="135.155" gradientUnits="userSpaceOnUse">
<stop stop-color="#6E6F6F"/>
<stop offset="0.247674" stop-color="#C3C3C3"/>
<stop offset="0.705564" stop-color="#717171"/>
<stop offset="1" stop-color="#373737"/>
</linearGradient>
<linearGradient id="paint9_linear" x1="0.0270431" y1="18.443" x2="4.1916" y2="18.443" gradientUnits="userSpaceOnUse">
<stop stop-color="#6E6F6F"/>
<stop offset="0.247674" stop-color="#C3C3C3"/>
<stop offset="0.705564" stop-color="#717171"/>
<stop offset="1" stop-color="#373737"/>
</linearGradient>
<linearGradient id="paint10_linear" x1="17.3652" y1="8.92406" x2="17.3652" y2="1.01098e-05" gradientUnits="userSpaceOnUse">
<stop stop-color="#6E6F6F"/>
<stop offset="0.247674" stop-color="#C3C3C3"/>
<stop offset="0.705564" stop-color="#717171"/>
<stop offset="1" stop-color="#373737"/>
</linearGradient>
<linearGradient id="paint11_linear" x1="17.3652" y1="8.92406" x2="17.3652" y2="1.01098e-05" gradientUnits="userSpaceOnUse">
<stop stop-color="#6E6F6F"/>
<stop offset="0.247674" stop-color="#C3C3C3"/>
<stop offset="0.705564" stop-color="#717171"/>
<stop offset="1" stop-color="#373737"/>
</linearGradient>
</defs>
<path fill-rule="evenodd" clip-rule="evenodd" d="M75.4975 1H838.142C900.717 1 905.204 8.22903 905.204 54.4631V1852.16C905.204 1887.15 900.718 1900 854.186 1900H59.4542C5.69713 1900 6.02688 1883.93 6.02688 1844.13V54.4631C6.02688 8.22903 8.91185 1 75.4975 1Z" fill="#D5D5D5"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M75.4975 1H838.142C900.717 1 905.204 8.22903 905.204 54.4631V1852.16C905.204 1887.15 900.718 1900 854.186 1900H59.4542C5.69713 1900 6.02688 1883.93 6.02688 1844.13V54.4631C6.02688 8.22903 8.91185 1 75.4975 1Z" fill="url(#paint0_radial)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M75.4975 1H838.142C900.717 1 905.204 8.22903 905.204 54.4631V1852.16C905.204 1887.15 900.718 1900 854.186 1900H59.4542C5.69713 1900 6.02688 1883.93 6.02688 1844.13V54.4631C6.02688 8.22903 8.91185 1 75.4975 1Z" fill="url(#paint1_radial)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M75.4975 1H838.142C900.717 1 905.204 8.22903 905.204 54.4631V1852.16C905.204 1887.15 900.718 1900 854.186 1900H59.4542C5.69713 1900 6.02688 1883.93 6.02688 1844.13V54.4631C6.02688 8.22903 8.91185 1 75.4975 1Z" fill="url(#paint2_radial)"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M75.4975 1H838.142C900.717 1 905.204 8.22903 905.204 54.4631V1852.16C905.204 1887.15 900.718 1900 854.186 1900H59.4542C5.69713 1900 6.02688 1883.93 6.02688 1844.13V54.4631C6.02688 8.22903 8.91185 1 75.4975 1Z" fill="url(#paint3_radial)"/>
<g filter="url(#filter0_iiiiiiii)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M75.4975 1H838.142C900.717 1 905.204 8.22903 905.204 54.4631V1852.16C905.204 1887.15 900.718 1900 854.186 1900H59.4542C5.69713 1900 6.02688 1883.93 6.02688 1844.13V54.4631C6.02688 8.22903 8.91185 1 75.4975 1Z" fill="black" fill-opacity="0.01"/>
</g>
<mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="6" y="1" width="900" height="1900">
<path fill-rule="evenodd" clip-rule="evenodd" d="M75.4975 1H838.142C900.717 1 905.204 8.22903 905.204 54.4631V1852.16C905.204 1887.15 900.718 1900 854.186 1900H59.4542C5.69713 1900 6.02688 1883.93 6.02688 1844.13V54.4631C6.02688 8.22903 8.91185 1 75.4975 1Z" fill="white"/>
</mask>
<g mask="url(#mask0)">
</g>
<mask id="mask1" mask-type="alpha" maskUnits="userSpaceOnUse" x="0" y="346" width="7" height="223">
<path d="M0 349.558C0 347.774 1.44625 346.328 3.23029 346.328H6.62932V568.711H3.23029C1.44625 568.711 0 567.265 0 565.481V349.558Z" fill="white"/>
</mask>
<g mask="url(#mask1)">
<g filter="url(#filter1_iiii)">
<path d="M0 349.558C0 347.774 1.44625 346.328 3.23029 346.328H6.62932V568.711H3.23029C1.44625 568.711 0 567.265 0 565.481V349.558Z" fill="url(#paint4_linear)"/>
</g>
</g>
<mask id="mask2" mask-type="alpha" maskUnits="userSpaceOnUse" x="0" y="685" width="7" height="117">
<path d="M0 688.232C0 686.461 1.43546 685.026 3.20618 685.026H6.62932V801.943H3.20618C1.43546 801.943 0 800.508 0 798.737V688.232Z" fill="white"/>
</mask>
<g mask="url(#mask2)">
<g filter="url(#filter2_iiii)">
<path d="M0 688.232C0 686.461 1.43546 685.026 3.20618 685.026H6.62932V801.943H3.20618C1.43546 801.943 0 800.508 0 798.737V688.232Z" fill="url(#paint5_linear)"/>
</g>
</g>
<g filter="url(#filter3_ddddd)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M69.7561 12.4507H844.488C897.494 12.4507 900.383 19.6812 900.383 65.925V1848.73C900.383 1875.69 897.494 1888.55 847.701 1888.55H64.9372C14.3412 1888.55 11.4507 1875.69 11.4507 1847.93L11.4507 65.1216C11.4507 20.4847 13.538 12.4507 69.7561 12.4507Z" fill="black"/>
</g>
<mask id="mask3" mask-type="alpha" maskUnits="userSpaceOnUse" x="11" y="12" width="890" height="1877">
<path fill-rule="evenodd" clip-rule="evenodd" d="M69.7561 12.4507H844.488C897.494 12.4507 900.383 19.6812 900.383 65.925V1848.73C900.383 1875.69 897.494 1888.55 847.701 1888.55H64.9372C14.3412 1888.55 11.4507 1875.69 11.4507 1847.93L11.4507 65.1216C11.4507 20.4847 13.538 12.4507 69.7561 12.4507Z" fill="white"/>
</mask>
<g mask="url(#mask3)">
<g filter="url(#filter4_iiiii)">
<rect x="11.4507" y="12.4507" width="888.932" height="1876.1" fill="black"/>
</g>
</g>
<circle cx="455.616" cy="72.1146" r="24.7093" fill="#141517"/>
<g filter="url(#filter5_d)">
<circle cx="455.616" cy="72.1147" r="16.272" fill="url(#paint6_linear)"/>
<circle cx="455.616" cy="72.1147" r="14.6327" stroke="black" stroke-width="3.2785"/>
</g>
<g filter="url(#filter6_d)">
<circle cx="455.615" cy="72.1144" r="7.83466" fill="black"/>
</g>
<mask id="mask4" mask-type="alpha" maskUnits="userSpaceOnUse" x="447" y="64" width="17" height="16">
<circle cx="455.615" cy="72.1144" r="7.83466" fill="white"/>
</mask>
<g mask="url(#mask4)">
<g filter="url(#filter7_f)">
<ellipse cx="451.246" cy="65.907" rx="11.3904" ry="2.4408" transform="rotate(-35 451.246 65.907)" fill="white"/>
</g>
<g opacity="0.811175" filter="url(#filter8_f)">
<ellipse cx="452.059" cy="68.7548" rx="2.4408" ry="1.2204" transform="rotate(-34 452.059 68.7548)" fill="white"/>
</g>
<g filter="url(#filter9_f)">
<ellipse cx="462.636" cy="77.2977" rx="11.3904" ry="2.4408" transform="rotate(-29 462.636 77.2977)" fill="#799585"/>
</g>
<circle cx="455.615" cy="72.1144" r="7.42484" stroke="black" stroke-width="0.819626"/>
</g>
<g filter="url(#filter10_dd)">
<rect width="12.0533" height="10.848" transform="matrix(1 0 0 -1 318.208 11.8481)" fill="url(#paint7_linear)"/>
<rect x="0.403786" y="-0.403786" width="11.2457" height="10.0404" transform="matrix(1 0 0 -1 318.208 11.0406)" stroke="black" stroke-opacity="0.1" stroke-width="0.807572"/>
</g>
<g filter="url(#filter11_dd)">
<rect x="6.02686" y="116.712" width="4.21866" height="18.6826" fill="url(#paint8_linear)"/>
<rect x="6.43064" y="117.116" width="3.41109" height="17.8751" stroke="black" stroke-opacity="0.1" stroke-width="0.807572"/>
</g>
<g filter="url(#filter12_dd)">
<rect width="4.21866" height="18.6826" transform="matrix(-1 0 0 1 905.204 116.712)" fill="url(#paint9_linear)"/>
<rect x="-0.403786" y="0.403786" width="3.41109" height="17.8751" transform="matrix(-1 0 0 1 904.397 116.712)" stroke="black" stroke-opacity="0.1" stroke-width="0.807572"/>
</g>
<g filter="url(#filter13_dd)">
<rect width="17.4773" height="9.03999" transform="matrix(1 0 0 -1 153.68 1899.4)" fill="url(#paint10_linear)"/>
<rect x="0.403786" y="-0.403786" width="16.6697" height="8.23242" transform="matrix(1 0 0 -1 153.68 1898.59)" stroke="black" stroke-opacity="0.1" stroke-width="0.807572"/>
</g>
<g filter="url(#filter14_dd)">
<rect width="17.4773" height="9.03999" transform="matrix(1 0 0 -1 739.471 1900)" fill="url(#paint11_linear)"/>
<rect x="0.403786" y="-0.403786" width="16.6697" height="8.23242" transform="matrix(1 0 0 -1 739.471 1899.19)" stroke="black" stroke-opacity="0.1" stroke-width="0.807572"/>
</g>
<g filter="url(#filter15_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M294.704 11.8481H616.334C616.334 12.1074 616.335 12.3841 616.334 12.6423C613.96 12.6423 610.854 17.2721 607.576 17.2721H303.461C300.242 17.2721 297.204 12.6423 294.704 12.6423C294.705 12.5619 294.717 12.0777 294.704 11.8481Z" fill="#323232"/>
</g>
<mask id="mask5" mask-type="alpha" maskUnits="userSpaceOnUse" x="294" y="11" width="323" height="7">
<path fill-rule="evenodd" clip-rule="evenodd" d="M294.704 11.8481H616.334C616.334 12.1074 616.335 12.3841 616.334 12.6423C613.96 12.6423 610.854 17.2721 607.576 17.2721H303.461C300.242 17.2721 297.204 12.6423 294.704 12.6423C294.705 12.5619 294.717 12.0777 294.704 11.8481Z" fill="white"/>
</mask>
<g mask="url(#mask5)">
<g opacity="0.795457" filter="url(#filter16_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M309.034 14.9473H314.607L313.014 17.2718H307.442L309.034 14.9473ZM297.888 14.9475H303.461L301.869 17.2721H296.296L297.888 14.9475ZM325.752 14.9473H320.179L318.587 17.2718H324.16L325.752 14.9473ZM331.325 14.9473H336.898L335.305 17.2718H329.733L331.325 14.9473ZM348.043 14.9473H342.471L340.878 17.2718H346.451L348.043 14.9473ZM353.616 14.9473H359.189L357.597 17.2718H352.024L353.616 14.9473ZM370.334 14.9473H364.762L363.169 17.2718H368.742L370.334 14.9473ZM375.907 14.9473H381.48L379.888 17.2718H374.315L375.907 14.9473ZM392.626 14.9473H387.053L385.461 17.2718H391.034L392.626 14.9473ZM398.198 14.9473H403.771L402.179 17.2718H396.606L398.198 14.9473ZM414.917 14.9473H409.344L407.752 17.2718H413.325L414.917 14.9473ZM420.49 14.9473H426.062L424.47 17.2718H418.897L420.49 14.9473ZM437.208 14.9473H431.635L430.043 17.2718H435.616L437.208 14.9473ZM442.781 14.9473H448.354L446.761 17.2718H441.189L442.781 14.9473ZM459.499 14.9473H453.926L452.334 17.2718H457.907L459.499 14.9473ZM465.072 14.9473H470.645L469.053 17.2718H463.48L465.072 14.9473ZM481.791 14.9473H476.218L474.626 17.2718H480.198L481.791 14.9473ZM487.363 14.9473H492.936L491.344 17.2718H485.771L487.363 14.9473ZM504.082 14.9473H498.509L496.917 17.2718H502.489L504.082 14.9473ZM509.655 14.9473H515.227L513.635 17.2718H508.062L509.655 14.9473ZM526.373 14.9473H520.8L519.208 17.2718H524.781L526.373 14.9473ZM531.946 14.9473H537.518L535.926 17.2718H530.353L531.946 14.9473ZM548.664 14.9473H543.091L541.499 17.2718H547.072L548.664 14.9473ZM554.237 14.9473H559.81L558.217 17.2718H552.645L554.237 14.9473ZM570.955 14.9473H565.382L563.79 17.2718H569.363L570.955 14.9473ZM576.528 14.9473H582.101L580.509 17.2718H574.936L576.528 14.9473ZM593.247 14.9473H587.674L586.081 17.2718H591.654L593.247 14.9473ZM598.819 14.9473H604.392L602.8 17.2718H597.227L598.819 14.9473ZM615.538 14.9473H609.965L608.373 17.2718H613.945L615.538 14.9473Z" fill="black"/>
</g>
<g filter="url(#filter17_i)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M294.704 11.8481H616.334C616.334 12.1074 616.335 12.3841 616.334 12.6423C613.96 12.6423 610.854 17.2721 607.576 17.2721H303.461C300.242 17.2721 297.204 12.6423 294.704 12.6423C294.705 12.5619 294.717 12.0777 294.704 11.8481Z" fill="black" fill-opacity="0.01"/>
</g>
</g>
<mask id="mask6" mask-type="alpha" maskUnits="userSpaceOnUse" x="11" y="12" width="890" height="1877">
<path fill-rule="evenodd" clip-rule="evenodd" d="M69.7581 12.4507H844.49C897.496 12.4507 900.385 19.6812 900.385 65.925V1848.73C900.385 1875.69 897.496 1888.55 847.703 1888.55H64.9392C14.3432 1888.55 11.4526 1875.69 11.4526 1847.93L11.4526 65.1216C11.4526 20.4847 13.5399 12.4507 69.7581 12.4507Z" fill="white"/>
</mask>
<g mask="url(#mask6)">
<g filter="url(#filter18_iiiiii)">
<rect x="11.4507" y="12.4507" width="888.932" height="1876.1" fill="black" fill-opacity="0.01"/>
</g>
</g>



</svg>
''',
    frameSize: Size(907.0, 1901.0),
    screenSize: Size(480.0, 1014.0),
  )
];
