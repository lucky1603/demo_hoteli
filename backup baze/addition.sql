
ALTER TABLE price
    ADD CONSTRAINT price_pk PRIMARY KEY (id);
ALTER TABLE reservation_entity
    ADD CONSTRAINT reservation_entity_pk PRIMARY KEY (id);
ALTER TABLE reservations
    ADD CONSTRAINT reservation_pk PRIMARY KEY (id);
ALTER TABLE reservation_status
    ADD CONSTRAINT rezervation_status_pk PRIMARY KEY (id);
ALTER TABLE role
    ADD CONSTRAINT role_pk PRIMARY KEY (id);
ALTER TABLE role_task
    ADD CONSTRAINT role_task_pk PRIMARY KEY (id);
ALTER TABLE status
    ADD CONSTRAINT status_pk PRIMARY KEY (id);
ALTER TABLE task
    ADD CONSTRAINT task_pk PRIMARY KEY (id);
ALTER TABLE title
    ADD CONSTRAINT title_pk PRIMARY KEY (id);
ALTER TABLE `user`
    ADD CONSTRAINT users_pk PRIMARY KEY (id);
ALTER TABLE `entity_definition` ADD INDEX ( entity_type_id ) ;
ALTER TABLE `entity` ADD INDEX ( definition_id ) ;
ALTER TABLE `entity_type_attribute` ADD INDEX ( attribute_id ) ;
ALTER TABLE `features_entity_definitions` ADD INDEX ( feature_id ) ;
ALTER TABLE `reservation_entity` ADD INDEX ( entity_id ) ;
ALTER TABLE `reservation_entity` ADD INDEX ( reservation_id ) ;
