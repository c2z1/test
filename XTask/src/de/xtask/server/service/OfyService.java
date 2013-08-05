package de.xtask.server.service;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyFactory;
import com.googlecode.objectify.ObjectifyService;

import de.xtask.domain.AppUser;
import de.xtask.domain.Task;

public class OfyService {
    static {
        factory().register(AppUser.class);
        factory().register(Task.class);
    }

    public static Objectify ofy() {
        return ObjectifyService.ofy();
    }

    public static ObjectifyFactory factory() {
        return ObjectifyService.factory();
    }
}
