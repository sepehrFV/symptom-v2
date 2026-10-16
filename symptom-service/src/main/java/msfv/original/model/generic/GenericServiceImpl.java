package msfv.original.model.generic;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;

public abstract class GenericServiceImpl<E, ID> implements GenericService<E, ID> {

    public static final Logger logger = LoggerFactory.getLogger(GenericServiceImpl.class);

    protected abstract GenericRepo<E, ID> getRepo();
    protected abstract Class<?> getExtendedClass();

    @Override
    @Transactional
    public E save(E entity) {
        logger.debug("Enter {}'s save()", getExtendedClass().getName());

        try {
            E savedEntity = getRepo().save(entity);
            logger.info("A new {} object has been saved successfully", getExtendedClass().getName());
            return savedEntity;
        } catch (DataAccessException ex) {
            logger.error("Database error while saving {}: {}", getExtendedClass().getName(), ex.getMessage(), ex);
            throw ex;
        }
    }

    @Override
    @Transactional(readOnly = true)
    public E getById(ID id) {
        logger.debug("Enter {}'s findById()", getExtendedClass().getName());

        return getRepo().findById(id)
                .orElseThrow(() -> new NoSuchElementException(
                        getExtendedClass().getName() + " not found with id: " + id
                ));
    }

    @Override
    @Transactional(readOnly = true)
    public E getByName(String name) {
        return getRepo().findByName(name);
    }

    @Override
    @Transactional(readOnly = true)
    public List<E> getAll() {
        logger.debug("Enter {}'s findAll()", getExtendedClass().getName());

        List<E> list = getRepo().findAll();

        logger.debug("Returned {} items", list.size());
        return list;
    }

    @Override
    @Transactional
    public void deleteById(ID id) {
        logger.debug("Enter {}'s delete()", getExtendedClass().getName());

        if (!getRepo().existsById(id)) {
            throw new IllegalArgumentException(
                    "Delete failed: id " + id + " does not exist"
            );
        }

        getRepo().deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existById(ID id) {
        return getRepo().existsById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existByName(String name) {
        return getRepo().existsByName(name);
    }
}