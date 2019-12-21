import { Injectable } from '@angular/core';

@Injectable()
export class ServiceService {

  public arrayDelService: Array<any>;

  setArray(array: any) {
    this.arrayDelService = array;
  }

  getArray() {
    return this.arrayDelService;
  }
}