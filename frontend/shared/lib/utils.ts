import {type ClassValue, clsx} from "clsx"
import {twMerge} from "tailwind-merge"
import {format, formatDistanceToNow} from "date-fns";
import { formatInTimeZone, toZonedTime } from "date-fns-tz";




const VANCOUVER_TZ = "America/Vancouver";   

export function cn(...inputs: ClassValue[]) {
    return twMerge(clsx(inputs))
}

/**
 * Converts an ISO string or Date to relative time (e.g., "2 days ago")
 */
export function formatToRelativeTime(dateInput: string | Date): string {
    if (!dateInput) return "N/A";
    try {
        const date = new Date(dateInput);
        const zoned = toZonedTime(date, VANCOUVER_TZ);
        return formatDistanceToNow(zoned, { addSuffix: true });
    } catch {
        return "Invalid date";
    }
}

/**
 * Converts an ISO string or Date to "yyyy/MM/dd HH:mm:ss"
 */
export function formatToDateTime(dateInput: string | Date): string {
    if (!dateInput) return "N/A";
    try {
       return formatInTimeZone(new Date(dateInput), VANCOUVER_TZ, "MMM d, yyyy");
    } catch {
        return "Invalid date";
    }
}

/**
 * Converts an ISO string or Date to "yyyy/MM/dd"
 */
export function formatToDate(dateInput: string | Date): string {
    if (!dateInput) return "N/A";
    try {
        return format(new Date(dateInput), "yyyy/MM/dd");
    } catch {
        return "Invalid date";
    }
}