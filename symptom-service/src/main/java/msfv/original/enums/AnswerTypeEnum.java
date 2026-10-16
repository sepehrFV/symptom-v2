package msfv.original.enums;

import java.util.stream.Stream;

public enum AnswerTypeEnum {

    YES((short) 1),
    NO((short) 2),
    UNKNOWN((short) 3);

    public final short code;

    AnswerTypeEnum(short code) {
        this.code = code;
    }

    public static AnswerTypeEnum findByCode(short code) {
        return Stream.of(values()).filter(answer -> answer.code == code).findFirst().orElse(UNKNOWN);
    }

}
