package msfv.original.model.generic;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.NoRepositoryBean;

import java.util.List;
import java.util.Optional;

@NoRepositoryBean
public interface GenericRepo<E, ID> extends JpaRepository<E, ID> {

    List<E> findAll();
    Optional<E> findById(ID id);
    boolean existsByName(String name);
    E findByName(String name);

}
