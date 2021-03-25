using { pcFactory as my } from '../db/schema';

@(path: '/GeneralService')
service genService @(_requires: 'admin') {
    entity Producto as projection on my.Producto;
    @readonly
    entity Proveedor as projection on my.Proveedor;
}

@(path: '/AuthService')
service authService @(requires: 'authenticated-user') {
    entity Producto as projection on my.Producto;
    @readonly
    entity Proveedor as projection on my.Proveedor;
}

@(path: '/AdminService')
service adminService @(requires: 'Scope1') {
    entity Producto as projection on my.Producto;
    @readonly
    entity Proveedor as projection on my.Proveedor;
}