#include<stdio.h>
#include<stdlib.h>
int main()
{
  int ad,ab,r,g,b;
  char *obj_id,*usr_obj_id,*usr_lbl,*usr_cmt,*tmpl_id;
  obj_id=(char*)malloc(sizeof(char)*100);
  usr_obj_id=(char*)malloc(sizeof(char)*100);
  usr_lbl=(char*)malloc(sizeof(char)*100);
  usr_cmt=(char*)malloc(sizeof(char)*100);
  tmpl_id=(char*)malloc(sizeof(char)*100);
  scanf("%s%s%s%s%s%d%d%d%d%d",obj_id,usr_obj_id,usr_lbl,usr_cmt,tmpl_id,&ad,&ab,&r,&g,&b);
  printf("<?xml version=\"1.0\" encoding=\"ISO-8859-15\"?>\n<doorTemplate>\n<objectID> %s </objectID>\n<objectType> 2 </objectType>\n<userDefinedObjectID> %s </userDefinedObjectID>\n<userLabel> %s </userLabel>\n<userComment> %s </userComment>\n<doorTemplateID> %s </doorTemplateID>\n<rectDims>\n<AD>  %d  </AD>\n<AB>  %d  </AB>\n</rectDims>\n<color>\n(%d, %d, %d)\n</color>\n</doorTemplate>\n",obj_id,usr_obj_id,usr_lbl,usr_cmt,tmpl_id,ad,ab,r,g,b);
  return 0;
}
