package com.example.devopsapp.config;

import net.rubyeye.xmemcached.XMemcachedClient;
import net.rubyeye.xmemcached.MemcachedClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.support.SimpleCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;

@Configuration
@EnableCaching
public class MemcachedConfig {

    // Inject memcached servers from application.properties
    @Value("${memcached.servers}")
    private String memcachedServers;

    @Bean
    public MemcachedClient memcachedClient() throws IOException {
        // Parse the servers string (format: host:port)
        String[] serverParts = memcachedServers.split(":");
        String host = serverParts[0];
        int port = serverParts.length > 1 ? Integer.parseInt(serverParts[1]) : 11211;
        
        return new XMemcachedClient(host, port);
    }

    @Bean
    public CacheManager cacheManager() {
        return new SimpleCacheManager();
    }
}
