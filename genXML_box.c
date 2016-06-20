#include<stdio.h>
#include<stdlib.h>
int main()
{
  int n;
  float ad,ab,ae;
  char *obj_id,*usr_cmt,*fr_w,*fr_o,*ba_w,*ba_o,*le_w,*le_o,*rt_w,*rt_o,*ro_w,*ro_o,*fl_w,*fl_o;
  //obj_id=(char*)malloc(sizeof(char)*100);
  //usr_obj_id=(char*)malloc(sizeof(char)*100);
  //  usr_lbl=(char*)malloc(sizeof(char)*100);
  usr_cmt=(char*)malloc(sizeof(char)*100);
  fr_w=(char*)malloc(sizeof(char)*100);
  fr_o=(char*)malloc(sizeof(char)*100);
  ba_w=(char*)malloc(sizeof(char)*100);
  ba_o=(char*)malloc(sizeof(char)*100);
  le_w=(char*)malloc(sizeof(char)*100);
  le_o=(char*)malloc(sizeof(char)*100);
  rt_w=(char*)malloc(sizeof(char)*100);
  rt_o=(char*)malloc(sizeof(char)*100);
  ro_w=(char*)malloc(sizeof(char)*100);
  ro_o=(char*)malloc(sizeof(char)*100);
  fl_w=(char*)malloc(sizeof(char)*100);
  fl_o=(char*)malloc(sizeof(char)*100);
  
  //tmpl_id=(char*)malloc(sizeof(char)*100);
  scanf("%d%s%f%f%f%s%s%s%s%s%s%s%s%s%s%s%s",&n,usr_cmt,&ad,&ab,&ae,fr_w,fr_o,ba_w,ba_o,le_w,le_o,rt_w,rt_o,ro_w,ro_o,fl_w,fl_o);
  printf("<?xml version=\"1.0\" encoding=\"ISO-8859-15\"?>\n<boxTemplate>\n<objectID> w%d </objectID>\n<objectType> 3 </objectType>\n<userDefinedObjectID> box%d </userDefinedObjectID>\n<userLabel> box_%dx%dx%d </userLabel>\n<userComment> %s </userComment>\n<boxTemplateID> b_%d </boxTemplateID>\n<boxDimsOuter>\n<AD>  %d  </AD>\n<AB>  %d  </AB>\n<AE> %d </AE></boxDimsOuter>\n<boxDimsInner>\n<AD>  0  </AD>\n<AB>  0  </AB>\n<AE> 0 </AE></boxDimsInner>\n<isContainerFlag> false </isContainerFlag>\n<faceWalls>\n<frontFace>\n<wallTemplateID> %s </wallTemplateID>\n<wallOrientation> (%s) </wallOrientation>\n</frontFace>\n<backFace>\n<wallTemplateID> %s </wallTemplateID>\n<wallOrientation> (%s) </wallOrientation>\n</backFace>\n<leftFace>\n<wallTemplateID> %s </wallTemplateID>\n<wallOrientation> (%s) </wallOrientation>\n</leftFace>\n<rightFace>\n<wallTemplateID> %s </wallTemplateID>\n<wallOrientation> (%s) </wallOrientation>\n</rightFace>\n<roofFace>\n<wallTemplateID> %s </wallTemplateID>\n<wallOrientation> (%s) </wallOrientation>\n</roofFace>\n<floorFace>\n<wallTemplateID> %s </wallTemplateID>\n<wallOrientation> (%s) </wallOrientation>\n</floorFace>\n</faceWalls>\n<numberOfDirectChildBoxes> 0 </numberOfDirectChildBoxes>\n</boxTemplate>\n",n,n,(int)ad,(int)ab,(int)ae,usr_cmt,n,(int)(ad*10),(int)(ab*10),(int)(ae*10),fr_w,fr_o,ba_w,ba_o,le_w,le_o,rt_w,rt_o,ro_w,ro_o,fl_w,fl_o);
  return 0;
}
