import { DateTime } from "luxon";

export default class DateFormatter {
  private readonly dateFormat: string;

  constructor(dateFormat: string) {
    this.dateFormat = dateFormat;
  }

  format(a: DateTime): string {
    return a.setZone(EXCHANGE_TIMEZONE).toFormat(this.dateFormat);
  }

  formatISOString(a: string): string {
    return DateTime.fromISO(a)
      .setZone(EXCHANGE_TIMEZONE)
      .toFormat(this.dateFormat);
  }

  safeFormat(a: DateTime | null | undefined): string {
    if (a !== null && a !== undefined) {
      return this.format(a);
    } else {
      return "";
    }
  }

  safeFormatJSDate(a: Date | null | undefined): string {
    if (a !== null && a !== undefined) {
      return this.format(DateTime.fromJSDate(a));
    } else {
      return "";
    }
  }

  safeFormatISOString(a: string | null | undefined): string {
    if (a !== null && a !== undefined) {
      return this.formatISOString(a);
    } else {
      return "";
    }
  }

  parse(value: string): DateTime | null {
    const date = DateTime.fromFormat(
      value,
      this.dateFormat
    );
    if (date.isValid) {
      return date;
    } else {
      return null;
    }
  }
}

export function getStartOfDateTime(year: number, month: number, day = 1) {
  const expiry = new Date();
  expiry.setFullYear(year);
  expiry.setMonth(month - 1);
  expiry.setDate(day ?? 1);
  expiry.setHours(
    0,
    0,
    0,
    0
  );
  const dateTime = DateTime.fromJSDate(expiry);
  return dateTime;
}

export const EXCHANGE_TIMEZONE = "Australia/Sydney";
export const DATE_FORMATTER = new DateFormatter("dd/MM/yyyy");
export const DATE_FORMATTER_ALT = new DateFormatter("yyyy-MM-dd");
export const DATE_TIME_FORMATTER = new DateFormatter("dd/MM/yyyy h:mma");
export const DOWNLOAD_DATE_FORMATTER = new DateFormatter("ddMMyyyy");
export const DATE_FORMATTER_DISPLAY = new DateFormatter("dd MMM yyyy");
