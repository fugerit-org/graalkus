package org.fugerit.java.demo.graalkus;

import io.quarkus.runtime.StartupEvent;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Observes;
import jakarta.inject.Inject;
import org.fugerit.java.doc.base.config.InitHandler;

@ApplicationScoped
public class AppInit {

    @Inject
    DocHelper docHelper;

    void onStart(@Observes StartupEvent ev) {
        InitHandler.initDocAllAsync(docHelper.getDocProcessConfig().getFacade().handlers());
    }

}
