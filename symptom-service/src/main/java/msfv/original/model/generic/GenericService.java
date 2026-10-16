package msfv.original.model.generic;

import java.util.List;

public interface GenericService<E, ID> {

    E save(E entity);
    E update(ID id, E entity);
    E getById(ID id);
    E getByName(String name);
    List<E> getAll();
    void deleteById(ID id);
    boolean existById(ID id);
    boolean existByName(String name);

}
