package msfv.original.enums;

import java.util.HashMap;
import java.util.Map;

public enum SeverityEnum {
    MILD("Mild", (short) 1),
    MODERATE("Moderate", (short) 2),
    SEVERE("Severe", (short) 3),
    CRITICAL("Critical", (short) 4),
    FATAL("Fatal", (short) 5);

    private static final Map<Short, SeverityEnum> map = new HashMap<>();

    static {
        for (SeverityEnum item : values()) {
            map.put(item.getSeverityIndex(), item);
        }
    }

    private final String severityLevel;
    private final short severityIndex;

    SeverityEnum(String severityLevel, short severityIndex) {
        this.severityLevel = severityLevel;
        this.severityIndex = severityIndex;
    }

    public static SeverityEnum valueOf(short id) {
        return map.get(id);
    }

    public String getSeverityLevel() {
        return severityLevel;
    }

    @Override
    public String toString() {
        return severityLevel;
    }

    public short getSeverityIndex() {
        return severityIndex;
    }
}