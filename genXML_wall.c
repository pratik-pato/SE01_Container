#include<stdio.h>
#include<stdlib.h>
int main()
{
  int n,r,g,b;
  float ad,ab;
  char *obj_id,*usr_obj_id,*usr_lbl,*usr_cmt,*tmpl_id;
  //obj_id=(char*)malloc(sizeof(char)*100);
  //usr_obj_id=(char*)malloc(sizeof(char)*100);
  //  usr_lbl=(char*)malloc(sizeof(char)*100);
  usr_cmt=(char*)malloc(sizeof(char)*100);
  //tmpl_id=(char*)malloc(sizeof(char)*100);
  scanf("%d%s%f%f%d%d%d",&n,usr_cmt,&ad,&ab,&r,&g,&b);
  printf("<?xml version=\"1.0\" encoding=\"ISO-8859-15\"?>\n<wallTemplate>\n<objectID> w%d </objectID>\n<objectType> 1 </objectType>\n<userDefinedObjectID> wall%d </userDefinedObjectID>\n<userLabel> wall_%dx%d </userLabel>\n<userComment> %s </userComment>\n<wallTemplateID> w_%d </wallTemplateID>\n<rectDims>\n<AD>  %d  </AD>\n<AB>  %d  </AB>\n</rectDims>\n<color>\n(%d, %d, %d)\n</color>\n<numberOfDoors> 0 </numberOfDoors>\n</wallTemplate>\n",n,n,(int)ad,(int)ab,usr_cmt,n,(int)(ad*10),(int)(ab*10),r,g,b);
  return 0;
}
