package msfv.original.model.disease;

import msfv.original.enums.SymptomEnum;
import msfv.original.model.generic.GenericRepo;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface DiseaseRepo extends GenericRepo<Disease, Long> {

    // we use join fetch to prevent Hibernate Throwing LazyInitializationException
    @Query("SELECT d FROM Disease d JOIN FETCH d.symptoms WHERE LOWER(d.name) IN :names")
    Set<Disease> findAllByNameIn(Set<String> names);

    /** case-insensitive lookup by name without join-fetching symptoms (used by the diagnosis result mapping) */
    @Query("SELECT d FROM Disease d WHERE LOWER(d.name) IN :names")
    List<Disease> findAllByLowerNameIn(@Param("names") java.util.Collection<String> names);

    @Query("""
    SELECT DISTINCT d FROM Disease d
    WHERE d.id IN (
        SELECT ds.id FROM Disease ds
        JOIN ds.symptoms s
        WHERE s IN :symptoms
        GROUP BY ds.id
        HAVING COUNT(DISTINCT s) = :#{#symptoms.size()}
    )
    """)
    Set<Disease> findDiseasesContainingAllSymptoms(@Param("symptoms") List<SymptomEnum> symptoms);

    @Query("""
                SELECT DISTINCT d
                FROM Disease d
                JOIN d.symptoms s
                WHERE s IN :symptoms
            """)
    Set<Disease> findDiseasesBySymptoms(@Param("symptoms") List<SymptomEnum> symptoms);

    @Query("""
                SELECT DISTINCT d.name
                FROM Disease d
                JOIN d.symptoms s
                WHERE s IN :symptoms
            """)
    Set<String> findDiseaseNamesBySymptoms(@Param("symptoms") List<SymptomEnum> symptoms);
}
