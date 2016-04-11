#!/usr/bin/python

import validateDoorWall

def main():
  validateDoorWall.fnGetWallDoorDimension('w13','d1',10,10,'ABCD')
  validateDoorWall.fnGetWallDoorDimension('w01','d1',50000,50000,'BCDA')
  validateDoorWall.fnGetWallDoorDimension('w01','d1',10,10,'ABCD')
main()
