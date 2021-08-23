import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/modules/login/store/login_store.dart';
import 'package:uni_match/widgets/my_circular_progress.dart';
import 'package:uni_match/widgets/svg_icon.dart';

// class SelectUniversity extends StatelessWidget {
//   const SelectUniversity({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class SelectUniversity extends StatefulWidget {
  SelectUniversity({Key? key}) : super(key: key);

  @override
  _SelectUniversityState createState() => _SelectUniversityState();
}

class _SelectUniversityState
    extends ModularState<SelectUniversity, LoginStore> {

  @override
  void initState() {
    if(controller.initList.isEmpty)
       controller.getUniversities();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Observer(
          builder:(_) => SafeArea(
            child: controller.loadList
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              Modular.to.pop();
                            },
                            icon: Icon(Icons.arrow_back)),
                      ),
                      Expanded(
                        child: MyCircularProgress(
                          size: 60,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              Modular.to.pop();
                            },
                            icon: Icon(Icons.arrow_back)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: controller.editingController,
                          cursorColor: Colors.grey[700],
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(28)),
                                borderSide: BorderSide(
                                  width: 1.8,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              hintStyle: TextStyle(color: Colors.grey[700]),
                              labelStyle: TextStyle(
                                  color: Colors.grey[600], fontSize: 18),
                              labelText: controller.i18n.translate("school"),
                              hintText: controller.i18n
                                  .translate("enter_your_school_name"),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child:
                                    SvgIcon("assets/icons/university_icon.svg"),
                              )),
                          onChanged: (value) {
                            controller.filterSearch(value);
                          },
                        ),
                      ),
                      controller.showItemList.isEmpty
                          ? Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  'Nenhuma Universidade encontrada!',
                                  style: GoogleFonts.eczar(fontSize: 22),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.showItemList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      Modular.to.pop(controller.showItemList[index].name);
                                    },
                                    child: ListTile(
                                      title: Text('${controller.showItemList[index].name}',
                                        style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text('${controller.showItemList[index].fullName}',
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
