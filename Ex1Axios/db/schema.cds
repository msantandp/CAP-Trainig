using { cuid } from '@sap/cds/common';
namespace axiosEx;

entity Technology : cuid {
    ShortDesc: String;
    ShortName: String;
};