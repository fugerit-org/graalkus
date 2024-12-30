package org.fugerit.java.demo.graalkus;

import io.quarkus.runtime.StartupEvent;
import io.quarkus.runtime.annotations.RegisterForReflection;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Observes;
import jakarta.inject.Inject;
import lombok.extern.slf4j.Slf4j;
import org.fugerit.java.doc.base.config.InitHandler;

@Slf4j
@ApplicationScoped
@RegisterForReflection(targets = { DocHelper.class, People.class })
public class AppInit {

    @Inject
    DocHelper docHelper;

    void onStart(@Observes StartupEvent ev) {
        InitHandler.initDocAllAsync(docHelper.getDocProcessConfig().getFacade().handlers());
    }

}
