package msfv.original.model.generic;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

public abstract class GenericController<E, ID> {

    protected abstract GenericService<E, ID> getService();

    /**
     * GET /{entity} - Get all entities (cached for 10 minutes).
     */
    @GetMapping("")
    @Cacheable(
            value = "diseases",
            unless = "#result == null or #result.body == null or #result.body.isEmpty()"
    )
    public ResponseEntity<List<E>> getAll() {
        List<E> entities = getService().getAll();
        return ResponseEntity.ok(entities);
    }

    /**
     * POST /{entity} - Save a new entity (invalidates cache).
     */
    @PostMapping("")
    @CacheEvict(value = "diseases", allEntries = true)
    public ResponseEntity<E> save(@RequestBody E entity) {
        E savedEntity = getService().save(entity);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedEntity);
    }

    /**
     * DELETE /{entity}/{id} - Delete an entity by ID (invalidates cache).
     */
    @DeleteMapping("/{id}")
    @CacheEvict(value = "diseases", allEntries = true)
    public ResponseEntity<Void> delete(@PathVariable ID id) {
        try {
            getService().deleteById(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    /**
     * GET /{entity}/{id} - Get an entity by ID (cached).
     */
    @GetMapping("/{id}")
    @Cacheable(value = "diseases", key = "#id", unless = "#result == null")
    public ResponseEntity<E> getById(@PathVariable ID id) {
        E entity = getService().getById(id);
        return ResponseEntity.ok(entity);
    }
}