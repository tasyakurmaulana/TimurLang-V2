// ============================================
// TimurLang - Real OpenStreetMap Calibrated Hiking Trails
// Koordinat GPS riil diekstrak langsung dari OpenStreetMap (OSM)
// ============================================

import 'package:latlong2/latlong.dart';
import '../services/trail_service.dart';

class RealTrailData {
  // ── 1. GUNUNG ANDONG (Magelang, Jawa Tengah) ──
  // Puncak Utama Andong: LatLng(-7.388669, 110.371555)

  /// Jalur Sawit Baru (91 Titik Akurat OSM)
  /// Melewati: Basecamp Sawit -> Pos 1 Watu Pocong -> Pos 2 Watu Gambir -> Pos 3 Gambar Wayang -> Camp Area -> Puncak Andong
  static const List<LatLng> andongSawitTrail = [
    LatLng(-7.393157, 110.37616), LatLng(-7.393131, 110.376032), LatLng(-7.393013, 110.375826), LatLng(-7.392818, 110.375553),
    LatLng(-7.392633, 110.375304), LatLng(-7.392397, 110.374943), LatLng(-7.392367, 110.374897), LatLng(-7.392301, 110.374823),
    LatLng(-7.392348, 110.374693), LatLng(-7.392331, 110.374194), LatLng(-7.392395, 110.374048), LatLng(-7.392537, 110.373991),
    LatLng(-7.392778, 110.373857), LatLng(-7.392964, 110.37359), LatLng(-7.39315, 110.373365), LatLng(-7.393339, 110.373284),
    LatLng(-7.393661, 110.373216), LatLng(-7.3939, 110.373099), LatLng(-7.394049, 110.372964), LatLng(-7.394046, 110.372912),
    LatLng(-7.393947, 110.372894), LatLng(-7.393909, 110.372869), LatLng(-7.393984, 110.372753), LatLng(-7.393977, 110.372702),
    LatLng(-7.393815, 110.372729), LatLng(-7.393782, 110.372705), LatLng(-7.393819, 110.372619), LatLng(-7.39381, 110.372579),
    LatLng(-7.393709, 110.372596), LatLng(-7.393602, 110.372578), LatLng(-7.393643, 110.37245), LatLng(-7.393616, 110.372426),
    LatLng(-7.39349, 110.372509), LatLng(-7.393479, 110.372444), LatLng(-7.393475, 110.372393), LatLng(-7.393427, 110.372377),
    LatLng(-7.39332, 110.372428), LatLng(-7.393272, 110.37236), LatLng(-7.393282, 110.372298), LatLng(-7.393244, 110.372176),
    LatLng(-7.393252, 110.372026), LatLng(-7.393179, 110.371978), LatLng(-7.393102, 110.371945), LatLng(-7.393114, 110.371862),
    LatLng(-7.393096, 110.371768), LatLng(-7.392957, 110.371691), LatLng(-7.392839, 110.371627), LatLng(-7.392691, 110.37158),
    LatLng(-7.392517, 110.371546), LatLng(-7.392452, 110.371541), LatLng(-7.392393, 110.371534), LatLng(-7.392317, 110.371528),
    LatLng(-7.39224, 110.371506), LatLng(-7.392172, 110.371496), LatLng(-7.392114, 110.371455), LatLng(-7.392002, 110.371414),
    LatLng(-7.391658, 110.371255), LatLng(-7.391601, 110.371216), LatLng(-7.391481, 110.371211), LatLng(-7.391145, 110.371081),
    LatLng(-7.390886, 110.370857), LatLng(-7.390816, 110.370816), LatLng(-7.390711, 110.370647), LatLng(-7.390492, 110.37043),
    LatLng(-7.390464, 110.37042), LatLng(-7.390437, 110.370417), LatLng(-7.390402, 110.370425), LatLng(-7.390388, 110.370392),
    LatLng(-7.3904, 110.370314), LatLng(-7.3904, 110.370224), LatLng(-7.390429, 110.370122), LatLng(-7.390501, 110.369926),
    LatLng(-7.390469, 110.369698), LatLng(-7.390493, 110.36949), LatLng(-7.390419, 110.369465), LatLng(-7.39019, 110.369478),
    LatLng(-7.389946, 110.369417), LatLng(-7.389842, 110.369357), LatLng(-7.38974, 110.369355), LatLng(-7.390008, 110.369853),
    LatLng(-7.389955, 110.36998), LatLng(-7.389928, 110.370219), LatLng(-7.389736, 110.370428), LatLng(-7.389514, 110.370613),
    LatLng(-7.389258, 110.370793), LatLng(-7.388962, 110.37108), LatLng(-7.388838, 110.371214), LatLng(-7.38864, 110.371495),
    LatLng(-7.388511, 110.371596), LatLng(-7.388669, 110.371555),
  ];

  /// Jalur Pendem (99 Titik Akurat OSM)
  /// Dari Dusun Pendem menaiki punggungan barat ke Puncak Makam & Puncak Andong
  static const List<LatLng> andongPendemTrail = [
    LatLng(-7.380133, 110.358086), LatLng(-7.380189, 110.358137), LatLng(-7.380238, 110.358212), LatLng(-7.380433, 110.358058),
    LatLng(-7.380595, 110.357879), LatLng(-7.380735, 110.357736), LatLng(-7.380808, 110.357675), LatLng(-7.38084, 110.357557),
    LatLng(-7.380804, 110.357453), LatLng(-7.380834, 110.357289), LatLng(-7.380912, 110.357168), LatLng(-7.381055, 110.357064),
    LatLng(-7.381074, 110.35697), LatLng(-7.381192, 110.356812), LatLng(-7.381182, 110.356686), LatLng(-7.381184, 110.356616),
    LatLng(-7.381271, 110.35656), LatLng(-7.381369, 110.356544), LatLng(-7.381473, 110.356605), LatLng(-7.381561, 110.356702),
    LatLng(-7.381735, 110.356774), LatLng(-7.381777, 110.356857), LatLng(-7.38186, 110.356855), LatLng(-7.382031, 110.356997),
    LatLng(-7.382101, 110.357189), LatLng(-7.382192, 110.357374), LatLng(-7.382335, 110.357545), LatLng(-7.382375, 110.357725),
    LatLng(-7.382502, 110.357924), LatLng(-7.382579, 110.357991), LatLng(-7.382627, 110.358224), LatLng(-7.382728, 110.358398),
    LatLng(-7.382883, 110.35857), LatLng(-7.382912, 110.358726), LatLng(-7.382981, 110.358822), LatLng(-7.383042, 110.358986),
    LatLng(-7.383212, 110.359211), LatLng(-7.383303, 110.359407), LatLng(-7.383433, 110.359506), LatLng(-7.383542, 110.359699),
    LatLng(-7.383694, 110.359839), LatLng(-7.383763, 110.359914), LatLng(-7.383923, 110.36016), LatLng(-7.384096, 110.360445),
    LatLng(-7.384244, 110.360643), LatLng(-7.384274, 110.360788), LatLng(-7.384338, 110.360933), LatLng(-7.384319, 110.360989),
    LatLng(-7.384303, 110.36114), LatLng(-7.38434, 110.361215), LatLng(-7.384455, 110.361255), LatLng(-7.384564, 110.361314),
    LatLng(-7.384673, 110.361459), LatLng(-7.384838, 110.361544), LatLng(-7.38509, 110.36162), LatLng(-7.385178, 110.36185),
    LatLng(-7.385271, 110.362068), LatLng(-7.385186, 110.362338), LatLng(-7.385239, 110.362537), LatLng(-7.385303, 110.362628),
    LatLng(-7.385428, 110.362668), LatLng(-7.385516, 110.362974), LatLng(-7.385644, 110.363175), LatLng(-7.385646, 110.363344),
    LatLng(-7.385692, 110.363554), LatLng(-7.385867, 110.363866), LatLng(-7.386, 110.364398), LatLng(-7.386019, 110.364622),
    LatLng(-7.386073, 110.36496), LatLng(-7.386164, 110.365261), LatLng(-7.386233, 110.36551), LatLng(-7.386337, 110.365648),
    LatLng(-7.386434, 110.36582), LatLng(-7.38649, 110.365909), LatLng(-7.38652, 110.366045), LatLng(-7.386629, 110.366221),
    LatLng(-7.386764, 110.366421), LatLng(-7.386897, 110.366528), LatLng(-7.387152, 110.3667), LatLng(-7.387318, 110.366878),
    LatLng(-7.387514, 110.367124), LatLng(-7.387668, 110.367232), LatLng(-7.387742, 110.367275), LatLng(-7.38784, 110.367275),
    LatLng(-7.387879, 110.367197), LatLng(-7.38793, 110.36724), LatLng(-7.388083, 110.367372), LatLng(-7.388172, 110.367474),
    LatLng(-7.38847, 110.367735), LatLng(-7.388708, 110.367935), LatLng(-7.388802, 110.368038), LatLng(-7.389043, 110.368329),
    LatLng(-7.38912, 110.36851), LatLng(-7.389176, 110.368639), LatLng(-7.389317, 110.368647), LatLng(-7.389393, 110.36866),
    LatLng(-7.389442, 110.368727), LatLng(-7.389422, 110.368879), LatLng(-7.389436, 110.368978), LatLng(-7.388669, 110.371555),
  ];

  /// Jalur Gogik (108 Titik Akurat OSM)
  /// Mulai dari Basecamp Gogik di Dusun Gogik mendaki lereng timur ke Puncak Alap-alap & Puncak Andong
  static const List<LatLng> andongGogikTrail = [
    LatLng(-7.387603, 110.382306), LatLng(-7.386738, 110.381246), LatLng(-7.386741, 110.381001), LatLng(-7.386664, 110.380886),
    LatLng(-7.386458, 110.380861), LatLng(-7.386297, 110.380903), LatLng(-7.386239, 110.380878), LatLng(-7.38623, 110.380822),
    LatLng(-7.386479, 110.380504), LatLng(-7.386535, 110.380433), LatLng(-7.386623, 110.380342), LatLng(-7.386436, 110.380172),
    LatLng(-7.386317, 110.38007), LatLng(-7.386215, 110.379932), LatLng(-7.386022, 110.379792), LatLng(-7.385878, 110.379478),
    LatLng(-7.38607, 110.3793), LatLng(-7.386205, 110.379407), LatLng(-7.386314, 110.379416), LatLng(-7.386476, 110.379522),
    LatLng(-7.386612, 110.379584), LatLng(-7.386693, 110.379574), LatLng(-7.386725, 110.379535), LatLng(-7.386744, 110.379414),
    LatLng(-7.38678, 110.37928), LatLng(-7.386787, 110.379211), LatLng(-7.386796, 110.379114), LatLng(-7.386855, 110.378999),
    LatLng(-7.386872, 110.378423), LatLng(-7.386669, 110.378284), LatLng(-7.386425, 110.378201), LatLng(-7.386244, 110.377858),
    LatLng(-7.386084, 110.377619), LatLng(-7.385823, 110.377337), LatLng(-7.385836, 110.377288), LatLng(-7.386098, 110.377318),
    LatLng(-7.386193, 110.377288), LatLng(-7.386338, 110.377308), LatLng(-7.38639, 110.37726), LatLng(-7.386106, 110.377069),
    LatLng(-7.386081, 110.37702), LatLng(-7.38609, 110.376971), LatLng(-7.386193, 110.376974), LatLng(-7.386443, 110.377073),
    LatLng(-7.38651, 110.377096), LatLng(-7.386564, 110.377084), LatLng(-7.386532, 110.376991), LatLng(-7.386452, 110.376895),
    LatLng(-7.38646, 110.376853), LatLng(-7.386626, 110.376884), LatLng(-7.38675, 110.376911), LatLng(-7.386823, 110.376873),
    LatLng(-7.387007, 110.376827), LatLng(-7.386989, 110.376731), LatLng(-7.386948, 110.376641), LatLng(-7.386867, 110.376583),
    LatLng(-7.386828, 110.37652), LatLng(-7.386788, 110.376503), LatLng(-7.386796, 110.376434), LatLng(-7.386809, 110.376394),
    LatLng(-7.386726, 110.376387), LatLng(-7.38673, 110.376351), LatLng(-7.386774, 110.376304), LatLng(-7.386767, 110.376261),
    LatLng(-7.386661, 110.376209), LatLng(-7.386635, 110.376164), LatLng(-7.386634, 110.376119), LatLng(-7.386639, 110.376033),
    LatLng(-7.386676, 110.375986), LatLng(-7.386643, 110.37591), LatLng(-7.386589, 110.375842), LatLng(-7.386575, 110.375735),
    LatLng(-7.386584, 110.375676), LatLng(-7.386574, 110.375638), LatLng(-7.386572, 110.37562), LatLng(-7.386557, 110.375603),
    LatLng(-7.386547, 110.375578), LatLng(-7.386519, 110.375541), LatLng(-7.386488, 110.375483), LatLng(-7.38651, 110.375456),
    LatLng(-7.38649, 110.375388), LatLng(-7.386508, 110.375351), LatLng(-7.386523, 110.375318), LatLng(-7.386492, 110.375264),
    LatLng(-7.386494, 110.37515), LatLng(-7.386538, 110.375071), LatLng(-7.386617, 110.374856), LatLng(-7.386656, 110.374706),
    LatLng(-7.386654, 110.374648), LatLng(-7.386704, 110.374583), LatLng(-7.386751, 110.37457), LatLng(-7.386756, 110.374517),
    LatLng(-7.386786, 110.374478), LatLng(-7.386793, 110.374424), LatLng(-7.386829, 110.3744), LatLng(-7.386888, 110.374223),
    LatLng(-7.38692, 110.374204), LatLng(-7.386942, 110.374088), LatLng(-7.386978, 110.37405), LatLng(-7.386962, 110.373938),
    LatLng(-7.386996, 110.373797), LatLng(-7.386963, 110.373442), LatLng(-7.38702, 110.373228), LatLng(-7.386978, 110.373006),
    LatLng(-7.386907, 110.372877), LatLng(-7.38688, 110.372736), LatLng(-7.386859, 110.372563), LatLng(-7.388669, 110.371555),
  ];

  // ── 2. GUNUNG PRAU (Dieng, Jawa Tengah) ──
  // Puncak Prau: LatLng(-7.1869, 109.9239)

  /// Jalur Patakbanteng (113 Titik Akurat OSM)
  static const List<LatLng> prauPatakbantengTrail = [
    LatLng(-7.200267, 109.934541), LatLng(-7.200258, 109.934244), LatLng(-7.200178, 109.934077), LatLng(-7.200152, 109.933935),
    LatLng(-7.200132, 109.933884), LatLng(-7.20009, 109.933775), LatLng(-7.199944, 109.933658), LatLng(-7.199831, 109.933566),
    LatLng(-7.199732, 109.933464), LatLng(-7.199585, 109.933371), LatLng(-7.199433, 109.933303), LatLng(-7.19936, 109.933284),
    LatLng(-7.199112, 109.933308), LatLng(-7.198926, 109.933314), LatLng(-7.198837, 109.933316), LatLng(-7.198737, 109.933326),
    LatLng(-7.198618, 109.933326), LatLng(-7.198446, 109.933267), LatLng(-7.198262, 109.933241), LatLng(-7.198057, 109.93319),
    LatLng(-7.197932, 109.933127), LatLng(-7.197786, 109.933078), LatLng(-7.197657, 109.933046), LatLng(-7.197569, 109.932957),
    LatLng(-7.197471, 109.932867), LatLng(-7.197364, 109.932789), LatLng(-7.197239, 109.932717), LatLng(-7.197131, 109.932642),
    LatLng(-7.197025, 109.932564), LatLng(-7.196933, 109.93252), LatLng(-7.196801, 109.932486), LatLng(-7.196644, 109.93243),
    LatLng(-7.196438, 109.932403), LatLng(-7.196256, 109.932345), LatLng(-7.19609, 109.932261), LatLng(-7.195907, 109.932163),
    LatLng(-7.195738, 109.932079), LatLng(-7.195565, 109.931997), LatLng(-7.19544, 109.93192), LatLng(-7.195295, 109.931838),
    LatLng(-7.195076, 109.931788), LatLng(-7.194873, 109.931712), LatLng(-7.194738, 109.931627), LatLng(-7.194573, 109.931525),
    LatLng(-7.194416, 109.931442), LatLng(-7.194297, 109.931378), LatLng(-7.194182, 109.931246), LatLng(-7.194055, 109.931101),
    LatLng(-7.193965, 109.931016), LatLng(-7.193854, 109.930948), LatLng(-7.193714, 109.93085), LatLng(-7.193577, 109.930724),
    LatLng(-7.193491, 109.930625), LatLng(-7.193367, 109.930471), LatLng(-7.19327, 109.93031), LatLng(-7.193252, 109.930172),
    LatLng(-7.193176, 109.930058), LatLng(-7.193093, 109.929929), LatLng(-7.193003, 109.929753), LatLng(-7.192945, 109.929584),
    LatLng(-7.192908, 109.929386), LatLng(-7.192854, 109.929203), LatLng(-7.192806, 109.929084), LatLng(-7.192768, 109.928958),
    LatLng(-7.192732, 109.928794), LatLng(-7.192666, 109.928629), LatLng(-7.192585, 109.928553), LatLng(-7.192409, 109.9285),
    LatLng(-7.192299, 109.928378), LatLng(-7.192147, 109.928282), LatLng(-7.191998, 109.928171), LatLng(-7.191866, 109.92807),
    LatLng(-7.191724, 109.927984), LatLng(-7.191607, 109.927892), LatLng(-7.1915, 109.927819), LatLng(-7.191371, 109.927736),
    LatLng(-7.19133, 109.927653), LatLng(-7.191248, 109.927543), LatLng(-7.191197, 109.927477), LatLng(-7.191146, 109.92729),
    LatLng(-7.191084, 109.927137), LatLng(-7.191007, 109.927048), LatLng(-7.190916, 109.926968), LatLng(-7.190828, 109.926869),
    LatLng(-7.190727, 109.926777), LatLng(-7.190582, 109.92671), LatLng(-7.190428, 109.9266), LatLng(-7.190354, 109.926463),
    LatLng(-7.190246, 109.926355), LatLng(-7.190157, 109.926253), LatLng(-7.190016, 109.926116), LatLng(-7.189942, 109.926084),
    LatLng(-7.189876, 109.926072), LatLng(-7.189756, 109.926021), LatLng(-7.189672, 109.92595), LatLng(-7.189544, 109.925857),
    LatLng(-7.189431, 109.925769), LatLng(-7.189376, 109.925678), LatLng(-7.189321, 109.925588), LatLng(-7.189238, 109.925487),
    LatLng(-7.189123, 109.92535), LatLng(-7.189034, 109.925238), LatLng(-7.188912, 109.925156), LatLng(-7.188688, 109.925055),
    LatLng(-7.188568, 109.924941), LatLng(-7.188418, 109.924816), LatLng(-7.188315, 109.924743), LatLng(-7.188114, 109.924615),
    LatLng(-7.187992, 109.924517), LatLng(-7.187844, 109.924397), LatLng(-7.187791, 109.924324), LatLng(-7.187626, 109.924104),
    LatLng(-7.18759, 109.924049),
  ];

  /// Jalur Dieng (116 Titik Akurat OSM)
  static const List<LatLng> prauDiengTrail = [
    LatLng(-7.199143, 109.916597), LatLng(-7.199074, 109.916695), LatLng(-7.198938, 109.916817), LatLng(-7.198844, 109.916896),
    LatLng(-7.198732, 109.916991), LatLng(-7.198617, 109.917059), LatLng(-7.198466, 109.917153), LatLng(-7.198314, 109.917196),
    LatLng(-7.198202, 109.917249), LatLng(-7.198105, 109.917281), LatLng(-7.197946, 109.917238), LatLng(-7.197856, 109.91722),
    LatLng(-7.197789, 109.91725), LatLng(-7.197737, 109.917322), LatLng(-7.197678, 109.917365), LatLng(-7.197617, 109.917415),
    LatLng(-7.197505, 109.917426), LatLng(-7.197421, 109.917418), LatLng(-7.197303, 109.917398), LatLng(-7.197222, 109.917368),
    LatLng(-7.197166, 109.917361), LatLng(-7.197064, 109.917394), LatLng(-7.196981, 109.917422), LatLng(-7.196913, 109.917396),
    LatLng(-7.196815, 109.917328), LatLng(-7.196654, 109.917174), LatLng(-7.196515, 109.916932), LatLng(-7.196487, 109.916866),
    LatLng(-7.196393, 109.916751), LatLng(-7.196328, 109.916618), LatLng(-7.196285, 109.916523), LatLng(-7.196237, 109.916488),
    LatLng(-7.196184, 109.916498), LatLng(-7.196145, 109.916553), LatLng(-7.196074, 109.916625), LatLng(-7.19606, 109.916707),
    LatLng(-7.195964, 109.916868), LatLng(-7.195826, 109.916935), LatLng(-7.19561, 109.916962), LatLng(-7.195439, 109.916934),
    LatLng(-7.195238, 109.916872), LatLng(-7.195146, 109.916958), LatLng(-7.195074, 109.917034), LatLng(-7.194993, 109.917145),
    LatLng(-7.194931, 109.917195), LatLng(-7.194867, 109.917328), LatLng(-7.194814, 109.917415), LatLng(-7.194746, 109.917489),
    LatLng(-7.194667, 109.917525), LatLng(-7.194582, 109.917617), LatLng(-7.194525, 109.91771), LatLng(-7.194498, 109.917837),
    LatLng(-7.194486, 109.917969), LatLng(-7.194456, 109.918064), LatLng(-7.194376, 109.918218), LatLng(-7.194285, 109.918307),
    LatLng(-7.194162, 109.918406), LatLng(-7.19407, 109.918519), LatLng(-7.193858, 109.918551), LatLng(-7.193765, 109.9186),
    LatLng(-7.193685, 109.918647), LatLng(-7.193596, 109.918666), LatLng(-7.193448, 109.918682), LatLng(-7.193329, 109.918706),
    LatLng(-7.19321, 109.918735), LatLng(-7.193078, 109.918798), LatLng(-7.192968, 109.918844), LatLng(-7.192879, 109.91885),
    LatLng(-7.192747, 109.918815), LatLng(-7.192548, 109.918768), LatLng(-7.192452, 109.918757), LatLng(-7.19238, 109.918705),
    LatLng(-7.192305, 109.918661), LatLng(-7.192208, 109.918579), LatLng(-7.192135, 109.918503), LatLng(-7.192053, 109.918372),
    LatLng(-7.191979, 109.918305), LatLng(-7.191906, 109.918229), LatLng(-7.191782, 109.918138), LatLng(-7.191635, 109.918114),
    LatLng(-7.191421, 109.918057), LatLng(-7.191257, 109.91806), LatLng(-7.191127, 109.91804), LatLng(-7.190987, 109.91798),
    LatLng(-7.190848, 109.917939), LatLng(-7.190758, 109.917907), LatLng(-7.190543, 109.918022), LatLng(-7.190388, 109.918206),
    LatLng(-7.190244, 109.918354), LatLng(-7.190139, 109.918457), LatLng(-7.190044, 109.918542), LatLng(-7.189966, 109.918618),
    LatLng(-7.189891, 109.918674), LatLng(-7.189755, 109.918816), LatLng(-7.189656, 109.918944), LatLng(-7.189558, 109.919103),
    LatLng(-7.189497, 109.919209), LatLng(-7.189479, 109.919405), LatLng(-7.189463, 109.919594), LatLng(-7.189454, 109.919738),
    LatLng(-7.18943, 109.919901), LatLng(-7.189406, 109.920034), LatLng(-7.189349, 109.920386), LatLng(-7.189266, 109.92064),
    LatLng(-7.189196, 109.920902), LatLng(-7.189143, 109.921075), LatLng(-7.189064, 109.921237), LatLng(-7.189013, 109.921398),
    LatLng(-7.188918, 109.921523), LatLng(-7.188802, 109.921631), LatLng(-7.188654, 109.921735), LatLng(-7.188509, 109.921835),
    LatLng(-7.18836, 109.921973), LatLng(-7.188222, 109.922114), LatLng(-7.188161, 109.922168), LatLng(-7.188125, 109.92217),
  ];

  /// Mengambil rute asli terkalibrasi jika tersedia
  static List<LatLng>? getRealTrail(String mountainName, String basecampName) {
    final m = mountainName.toLowerCase();
    final b = basecampName.toLowerCase();

    // 1. Gunung Andong
    if (m.contains('andong')) {
      if (b.contains('sawit')) return andongSawitTrail;
      if (b.contains('pendem')) return andongPendemTrail;
      if (b.contains('gogik')) return andongGogikTrail;
    }

    // 2. Gunung Prau
    if (m.contains('prau')) {
      if (b.contains('patakbanteng') || b.contains('patak')) return prauPatakbantengTrail;
      if (b.contains('dieng')) return prauDiengTrail;
    }

    return null;
  }

  /// Mengambil pos checkpoints asli terkalibrasi jika tersedia
  static List<TrailCheckpoint>? getRealCheckpoints(String mountainName, String basecampName) {
    final m = mountainName.toLowerCase();
    final b = basecampName.toLowerCase();

    if (m.contains('andong') && b.contains('sawit')) {
      return const [
        TrailCheckpoint(
          name: 'Basecamp Sawit',
          location: LatLng(-7.393157, 110.37616),
          elevationMdpl: 1250,
          description: 'Pos registrasi Simaksi dan gerbang pendakian via Sawit.',
          hasWater: true,
        ),
        TrailCheckpoint(
          name: 'Pos 1 Watu Pocong',
          location: LatLng(-7.391534, 110.374108),
          elevationMdpl: 1380,
          description: 'Bebatuan besar menyerupai pocong di lereng pinus rindang.',
          hasWater: false,
        ),
        TrailCheckpoint(
          name: 'Pos 2 Watu Gambir',
          location: LatLng(-7.391159, 110.373552),
          elevationMdpl: 1490,
          description: 'Shelter istirahat tengah jalur dengan warung logistik warga.',
          hasWater: false,
        ),
        TrailCheckpoint(
          name: 'Pos 3 Gambar Wayang',
          location: LatLng(-7.391097, 110.371081),
          elevationMdpl: 1610,
          description: 'Tebing batu dengan pahatan wayang alami sebelum punggungan atas.',
          hasWater: false,
        ),
        TrailCheckpoint(
          name: 'Camp Area Andong',
          location: LatLng(-7.389777, 110.370318),
          elevationMdpl: 1690,
          description: 'Area datar untuk mendirikan tenda dekat mata air dan warung puncak.',
          hasWater: true,
        ),
        TrailCheckpoint(
          name: 'Puncak Andong (Utama)',
          location: LatLng(-7.388669, 110.371555),
          elevationMdpl: 1726,
          description: 'Titik tertinggi 1.726 mdpl dengan panorama 360° spektakuler.',
          hasWater: false,
        ),
      ];
    }

    return null;
  }
}
