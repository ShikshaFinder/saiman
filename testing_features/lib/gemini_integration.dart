// ignore_for_file: unused_local_variable, avoid_print, dead_code, unnecessary_brace_in_string_interps, camel_case_types, non_constant_identifier_names
import 'dart:convert';

import 'package:http/http.dart' as http;

var gemeini_api_key_value = 'AIzaSyDy0HbiyebJsmPqQ0S3Xyc_PiMNbfAbGTA';

class gemini_api {
  static Future<Map<String, String>> getheader() async {
    return {
      'Content-Type': 'application/json',
    };
  }

  static Future<String> getgeminidata(pdf_data, message) async {
    try {
      final header = await getheader();

      final Map<String, dynamic> requestbody = {
        'contents': [
          {
            'parts': [
              {
                'text':
                    'user message request here i will provide you a set of questions from a question paper and you will have to store that questions suppose i am blind and dont know what is written on screen  so i will ask you question accordingly you will have to respond according to that question paper Prompted Class 8 Time : 3 hrs. PHYSICS (Time : 1 hr.; Max. Marks : 30) Multiple choice questions: (1x6=6) 1. Which of the following controls the amount of light entering the eye? a) Pupil b) Iris c) Cornea d) Ciliary muscles 2. Which of the following colours bends the most when light passes through a prism? a) Red b) Blue c) Yellow d) Violet 3. In a Kaleidoscope, the mirrors make an angle of with each other. a) 60° b) 45° c) 90° d) 30° 4. Ball bearings are useful because a) rolling friction > sliding friction b) rolling friction < sliding friction c) rolling friction = sliding friction d) they require less maintenance 5. Which of these cannot be changed by force acting on a body? 6. 7. What causes refraction of light when it passes from one medium to the other? (1) 8. Calculate the number of images formed if two mirrors are placed at an angle of 20° with respect to each other. (2) 9. Write two differences between myopia and hypermetropia. (Diagram NOT required). (2) 10. a) Give two advantages of friction in daily life. Also give two methods of increasing friction. b) What causes friction? (2+1) 11. State the laws of reflection. List two characteristics of an image formed by a plane mirror. (2+1) 12. Draw a neat and well labeled diagram to show the refraction by a glass slab. What is meant by lateral displacement? (2+1) 13. a) Differentiate between contact and non-contact force. Give two examples of each. a) Direction of motion b) State of rest c) Shape d) Mass Which of these is used to measure the pressure exerted by liquid? a) Barometer b) Manometer c) Pressure Gauge d) Both (b) and (c) b) What will be the amount of pressure exerted by a brick which applies a force of 2.5N, when (i) it is placed upright on the soil and (ii) it is placed on its widest base? The dimensions of the brick are 25cm x 10cm x 5cm. (2+3) 14. a) Draw a complete ray diagram to show the position of the image formed by a convex lens when the object placed between O and F. List the characteristics of image so formed. b) Define optical centre. (3+1+1) CHEMISTRY (Time : 1 hr.; Max. Marks : 30) Multiple Choice Questions: (1x6=6) 1. Metals react with oxygen to form a) Acidic Oxide b) either acidic or basic oxide depending on the metal c) basic oxide d) no reaction. 2. Which of these is a fibre derived from chemicals? a) Rayon b) Cotton c) Nylon d) Silk 3. Pieces of copper, silver and gold are dropped into a solution of ferrous sulphate. The piece that will get a coating of copper is a) Iron b) Silver c) Gold d) none of them. 4. Which gas is evolved when metals react with acids? a) Hydrogen b) Oxygen c) Carbon dioxide d) Water. 5. The metal most used in the construction industry is a) iron b) copper c) aluminium d) tin 6. Which of these plastics can be used to insulate the hollow walls of refrigerators? a) Perspex b) Teflon c) Polystyrene d) Polyethene. 7. What is plastic? What is a common property of all plastics? (1) 8. Name the following:- (½x4=2) a) The main source of plastic. b) Synthetic fibre used for making socks and stockings. c) Plastic used as a covering for electric wires. d) Plastic used for making table tops. 9. Define the terms: a) Non-metals b) Ductility (2) 10. Complete and balance the following equations: (1x3=3) a) Na + H2O → b) Al + HCl  c) Cu + O2  11. Answer the following questions: (1x3=3) a) What are the problems associated with improper disposal of plastic goods? b) Give any two uses of polyester. c) Why rayon is called a regenerated fibre? 12. (i) State whether a displacement reaction will occur in the following reaction. Give reason. CuSO4 + Zn → (ii) Write any two uses of graphite. (iii) School bells are made of metals. Give reason. (1x3=3) 13. a) Differentiate between thermoplastic and thermosetting plastic. (2 points) b) What is a metalloid? Give one example. c) What is 4R principle? d) Give the characteristics property and the uses of the following: i) Perspex ii) Teflon (1+1+1+2) 14. Answer the following questions: (½x10=5) a) What is the most common form of silica? b) Name the ore of Aluminium. c) Give an example for a noble gas element. d) Name a soft metal. e) Name the metal which is the best conductor of electricity. f) Name the metal which is used for packing food. g) Non-metal which is used in skin-ointments. h) Name the most abundant element in the universe. i) Name a liquid non-metal. j) Name the pure form of carbon. BIOLOGY (Time : 1 hr.; Max. Marks : 30) Multiple Choice Questions: (1x6=6) 1. Which of these cause water pollution? a) Sewage b) Industrial waste c) Fertilizers and pesticides d) All of these. 2. The egg of a hen is a a) Cell b) Tissue c) Organ d) Organ system 3. Which of these do not have a regular cell structure? a) Bacteria b) Viruses c) Algae d) Protozoa 4. Microorganisms spread through a) Air b) Cuts c) Water d) All of these 5. Which of these does not prevent growth of bacteria? a) Salt b) Sugar c) Water d) Oil 6. Amoeba is a a) Bacterium b) Virus c) Fungus d) Protozoa 7. Name the following. (½x4=2) 9. Which microorganisms act as decomposers? How is this activity useful to us? (2) 10. How do viruses cause disease? (2) 11. State the function of (½x4=2) a) Cilia b) Chloroplast c) Ribosomes d) Centrosomes 12. What are the main points of cell theory? (any 4) (2) 13. Give 4 ways to conserve water. (2) 14. Draw a neat & labelled diagram of animal cell & state any 3 differences between plant cell & animal cell. (5) 15. i) Discuss the different methods available to us for making water potable by killing germs. ii) What are water pollutants? (5) -x-x-x-x-x-x-xa) b) c) d) Control center of the cell . Spherical shaped bacteria . Power house of the cell . Sac like organelle in the plant cell which store food, water or waste . 8. a) b) What causes food poisoning? Why do you think curd turns sour faster in summer than in winter? (2) here is the question paper here is the question paper  "" here is the question regarding the question paper $message anf also dont provide me the answer of any question from the paper because it is a test for me even if i ask you to answer the question do not include * in your answer',
              }
            ]
          }
        ],
        'generationConfig': {'temperature': 0.8, 'maxOutputTokens': 1000}
      };

      String url =
          "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=${gemeini_api_key_value}";

      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(requestbody));
      print(response.body);

      if (response.statusCode == 200) {
        var json_response = jsonDecode(response.body) as Map<String, dynamic>;
        return json_response['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return '';
      }
    } catch (e) {
      return "";
      print('error : $e');
    }
  }
}
