package com.redhat.cloudnative.inventory;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.redhat.cloudnative.inventory.breakfix.service.BreakFixService;

@Path("/")
@ApplicationScoped
public class InventoryResource {

	@PersistenceContext(unitName = "InventoryPU")
    private EntityManager em;
	
	@Inject
	private BreakFixService breakFixService;

    @GET
    @Path("/api/inventory/{itemId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Inventory getAvailability(@PathParam("itemId") String itemId) {
        Inventory inventory = em.find(Inventory.class, itemId);
        
        // Break & Fix
        this.breakFixService.process();

        if (inventory == null) {
            inventory = new Inventory();
            inventory.setItemId(itemId);
            inventory.setQuantity(0);
        }

        return inventory;
    }
}
