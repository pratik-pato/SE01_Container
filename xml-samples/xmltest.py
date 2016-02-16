import xmltodict

with open('door.xml') as fd:
  obj = xmltodict.parse(fd.read())
  print obj
  print '=================================='
  print obj['doorTemplate']
  print '=================================='
  print obj['doorTemplate']['objectID']
  print '=================================='
  print obj['doorTemplate']['objectID'][8:13]
  print '=================================='
  print obj['doorTemplate']['rectDims']
  print '=================================='
  print obj['doorTemplate']['rectDims']['height']
