package msfv.original.model.generic;

import com.github.benmanes.caffeine.cache.CacheLoader;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.stats.CacheStats;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.CacheManager;
import org.springframework.cache.caffeine.CaffeineCacheManager;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping(value = "/cache")
@RequiredArgsConstructor
public class CacheStatsController {

    private final CacheManager cacheManager;

    /**
     * GET /cache/stats - Get cache statistics for all caches.
     */
    @GetMapping("/stats")
    public ResponseEntity<Map<String, Object>> getCacheStats() {
        Map<String, Object> stats = new HashMap<>();

        if (cacheManager instanceof CaffeineCacheManager caffeineCacheManager) {
            Map<String, Map<String, Object>> cacheStats = new HashMap<>();

            caffeineCacheManager.getCacheNames().forEach(cacheName -> {
                var cache = caffeineCacheManager.getCache(cacheName);
                if (cache != null && cache.getNativeCache() instanceof com.github.benmanes.caffeine.cache.Cache<?, ?> caffeineCache) {
                    CacheStats cacheStatsObj = caffeineCache.stats();
                    Map<String, Object> cacheDetail = new HashMap<>();
                    cacheDetail.put("hitCount", cacheStatsObj.hitCount());
                    cacheDetail.put("missCount", cacheStatsObj.missCount());
                    cacheDetail.put("loadSuccessCount", cacheStatsObj.loadSuccessCount());
                    cacheDetail.put("loadFailureCount", cacheStatsObj.loadFailureCount());
                    cacheDetail.put("evictionCount", cacheStatsObj.evictionCount());
                    cacheDetail.put("hitRate", cacheStatsObj.hitRate());
                    cacheDetail.put("size", caffeineCache.estimatedSize());

                    cacheStats.put(cacheName, cacheDetail);
                }
            });

            stats.put("caches", cacheStats);
            stats.put("message", "Cache statistics retrieved successfully");
        }

        return ResponseEntity.ok(stats);
    }

    /**
     * GET /cache/clear - Clear all caches.
     */
    @GetMapping("/clear")
    public ResponseEntity<Map<String, String>> clearAllCaches() {
        cacheManager.getCacheNames().forEach(cacheName -> {
            var cache = cacheManager.getCache(cacheName);
            if (cache != null) {
                cache.clear();
            }
        });

        return ResponseEntity.ok(Map.of("message", "All caches cleared successfully"));
    }
}
