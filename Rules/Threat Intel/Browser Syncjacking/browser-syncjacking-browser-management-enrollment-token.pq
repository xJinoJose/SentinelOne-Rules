| filter event.type = 'Registry Value Set'
        AND (registry.keyPath contains 'CloudManagementEnrollmentToken'
            OR registry.keyPath contains 'EdgeManagementEnrollmentToken')