package msfv.original.converter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import msfv.original.enums.SymptomEnum;

import java.io.IOException;
import java.util.Set;

@Converter(autoApply = false)
public class SymptomEnumJsonConverter
        implements AttributeConverter<Set<SymptomEnum>, String> {

    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    @Override
    public String convertToDatabaseColumn(Set<SymptomEnum> attribute) {
        if (attribute == null || attribute.isEmpty()) {
            return null;
        }
        try {
            return OBJECT_MAPPER.writeValueAsString(attribute);
        } catch (JsonProcessingException e) {
            throw new IllegalStateException("Failed to serialize symptoms", e);
        }
    }

    @Override
    public Set<SymptomEnum> convertToEntityAttribute(String dbData) {
        if (dbData == null || dbData.isBlank()) {
            return Set.of();
        }
        try {
            return OBJECT_MAPPER.readValue(
                    dbData,
                    OBJECT_MAPPER.getTypeFactory()
                            .constructCollectionType(Set.class, SymptomEnum.class)
            );
        } catch (IOException e) {
            throw new IllegalStateException("Failed to deserialize symptoms", e);
        }
    }
}
