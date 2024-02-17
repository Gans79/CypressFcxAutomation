import DateFormatter, { DATE_FORMATTER } from "./DateFormatter";
import { DateTime } from "luxon";
/* Actions */
export function convertTestDate(testDataDate: string): any {
  
  const today = DateTime.now();

  if (testDataDate.includes('[Today]') || testDataDate.includes('[Tomorrow]') || testDataDate.includes('[Yesterday]')) {
    switch (testDataDate) {
      case '[Today]':
        return DATE_FORMATTER.format(today);
        break;
      case '[Today] + 1': case '[Tomorrow]':
        return DATE_FORMATTER.format(today.plus({ days: 1 }));
        break;
      case '[Today] + 2':
        return DATE_FORMATTER.format(today.plus({ days: 2 }));
        break;
      case '[Today] + 14':
        return DATE_FORMATTER.format(today.plus({ days: 14 }));
        break;
      case '[Today] + 30':
        return DATE_FORMATTER.format(today.plus({ days: 30 }));
        break;
      case '[Today] + 60':
        return DATE_FORMATTER.format(today.plus({ days: 60 }));
        break;
      case '[Today] + 90':
        return DATE_FORMATTER.format(today.plus({ days: 90 }));
        break;      
      case '[Today] - 1': case '[Yesterday]':
        return DATE_FORMATTER.format(today.minus({ days: 1 }));
        break;
      case '[Today] + 1yr':
        return DATE_FORMATTER.format(today.minus({ years: 1 }));
        break;          
      default:
        throw new Error(testDataDate + ' date not defined.');
    }
  } else {
    return testDataDate;
  }
};

export function convertToCamelCase(input: string): string {
  const toCamelCase: string = input.replace(/(?:^\w|[A-Z]|\b\w)/g, (ltr, idx) => idx === 0 ? ltr.toLowerCase() : ltr.toUpperCase()).replace(/\s+/g, '');
  return toCamelCase;
};

export function convertToKebabCase(input: string): string {
  const toKebabCase: string = input.replace(/([a-z])([A-Z])/g, "$1-$2").replace(/[\s_]+/g, '-').toLowerCase();
  return toKebabCase;
};

export function toDateFormat(d: Date, format: string) {
  switch (format) {
    case 'DDMMYYYY':
      return `${String(d.getDate()).padStart(2, '0')}${String(d.getMonth() + 1).padStart(2, '0')}${d.getFullYear()}`;
    case 'YYYYMMDD':
      return `${d.getFullYear()}${String(d.getMonth() + 1).padStart(2, '0')}${String(d.getDate()).padStart(2, '0')}`;
    case 'YYYYMMDD_HHMISS':
      return `${d.getFullYear()}${String(d.getMonth() + 1).padStart(2, '0')}${String(d.getDate()).padStart(2, '0')}_${String(d.getHours()).padStart(2, '0')}${String(d.getMinutes()).padStart(2, '0')}${String(d.getSeconds()).padStart(2, '0')}`;
    default:
      return `${String(d.getDate()).padStart(2, '0')}/${String(d.getMonth() + 1).padStart(2, '0')}/${d.getFullYear()}`;
  }
}

export function replaceDateExpression(name: string, format: string) {
  return name.replace(format, toDateFormat(new Date(), format))
}


/* Assertions */
export function convertDateToDD_Mon_YYYY(testDataDate: string): any {
  const monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  let splitDate: {} = testDataDate.split('/');
  // cy.log(splitDate[2], splitDate[1], splitDate[0])
  const convertDay = new Date(splitDate[2], (splitDate[1] - 1), splitDate[0], 0, 0);
  // cy.log('convertedDate :', convertDay.toDateString());
  return (String(convertDay.getDate()).padStart(2, '0') + ' ' + monthNames[convertDay.getMonth()] + ' ' + convertDay.getFullYear());
};