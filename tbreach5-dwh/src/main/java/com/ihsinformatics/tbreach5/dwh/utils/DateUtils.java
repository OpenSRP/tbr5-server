package com.ihsinformatics.tbreach5.dwh.utils;

import org.joda.time.DateTime;

public class DateUtils {
	
	private static final String DB_DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";

	public static String todaysDatetimeDb() {
		return DateTime.now().toString(DB_DATETIME_FORMAT);
	}
	
	public static String formatDatetimeDb(DateTime date) {
		return date.toString(DB_DATETIME_FORMAT);
	}
	
	public static String formatDatetimeDb(Object date) {
		return parseDatetime(date).toString(DB_DATETIME_FORMAT);
	}
	
	public static DateTime parseDatetime(String date) {
		return DateTime.parse(date);
	}
	
	public static DateTime parseDatetime(Object date) {
		return parseDatetime(date.toString());
	}
}
