#!/bin/sh

# Install only if it is not already installed
if [ ! -d "/opt/DigitalExperienceManager-EnterpriseDistribution-7.1.2.1" ]; then
    # Launch installation using config XML file
    java -jar /tmp/DigitalExperienceManager.jar /tmp/configuration.xml
else
    # Clean temporary files (not needed anymore once installation is done)
    rm -rf /tmp/*
fi