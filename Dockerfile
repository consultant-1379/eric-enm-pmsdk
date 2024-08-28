

ARG ERIC_ENM_SLES_EAP7_IMAGE_NAME=eric-enm-sles-eap7
ARG ERIC_ENM_SLES_EAP7_IMAGE_REPO=armdocker.rnd.ericsson.se/proj-enm
ARG ERIC_ENM_SLES_EAP7_IMAGE_TAG=1.64.0-32
FROM ${ERIC_ENM_SLES_EAP7_IMAGE_REPO}/${ERIC_ENM_SLES_EAP7_IMAGE_NAME}:${ERIC_ENM_SLES_EAP7_IMAGE_TAG}



ARG BUILD_DATE=unspecified
ARG IMAGE_BUILD_VERSION=unspecified
ARG GIT_COMMIT=unspecified
ARG ISO_VERSION=unspecified
ARG RSTATE=unspecified

LABEL \
com.ericsson.product-number="CXC Placeholder" \
com.ericsson.product-revision=$RSTATE \
enm_iso_version=$ISO_VERSION \
org.label-schema.name="ENM PM SDK Base Image" \
org.label-schema.build-date=$BUILD_DATE \
org.label-schema.vcs-ref=$GIT_COMMIT \
org.label-schema.vendor="Ericsson" \
org.label-schema.version=$IMAGE_BUILD_VERSION \
org.label-schema.schema-version="1.0.0-rc1"

RUN zypper install -y  ERICmediationengineapi2_CXP9038435 \
ERICdpsruntimeimpl_CXP9030468 \
ERICsshcredentialsmanagerhandlercode_CXP9032068 \
ERICftphandlercode_CXP9030846 \
ERICpmmedcom2_CXP9038438 \
ERICmediationresolverspi2_CXP9038532 \
ERICdpsattributeresolver2_CXP9038437 \
ERICtssresolver2_CXP9038531 \
ERICconfigureattributeresolver2_CXP9038528 \
ERICrequestattributeresolver2_CXP9038529 \
ERICsfkattributeresolver2_CXP9039758 \
ERICpmicfilecollectionhandlerscode_CXP9030844 \
ERICftpjcaconnectorapi_CXP9031542 \
ERICftpjcaconnector_CXP9031543 \
ERICcryptographyservice_CXP9031013 \
ERICcryptographyserviceapi_CXP9031014 \
ERICdpsruntimeapi_CXP9030469 \
# <!-- JAVA 8 --> \
EXTRserverjre_CXP9035480 \
# <!-- EAP 7 bundle and config rpm --> \
EXTReap7_CXP9037438 \
ERICeap7config_CXP9037440 \
# <!-- SFWK --> \
ERICserviceframework4_CXP9037454 \
ERICserviceframeworkmodule4_CXP9037453 \
# <!-- Modeling rpms --> \
ERICmodelserviceapi_CXP9030594 \
ERICmodelservice_CXP9030595 \
# <!-- DDC --> \
ERICddc_CXP9030294 \
# <!-- PIB --> \
ERICpib2_CXP9037459 \
ERICsessionmanagerapi_CXP9031998 \
ERICsessionmanager_CXP9031997 \
ERICsshtransportconnecthandler_CXP9032167 \
ERICsshtransportlibrary_CXP9031609 \
ERICtransportapi_CXP9031610 \
ERICpmiccommonmoduleapi2_CXP9039548 \
ERICpmiccommonmoduleimpl_CXP9032400 \
ERICpmicmediationmodule_CXP9036438 \
ERICDpsDataRetrievalHandler_CXP9032387 \
ERICpmflowschedulerhandler_CXP9034528 \
ERICpmflowscheduler_CXP9034534 \
ERICflshandlercode_CXP9033301 \
ERICsshjcaconnector_CXP9031462 \
ERICsharedpmhandlerscode_CXP9035268 \
ERICpmiccommonscannerhandlercode_CXP9032591 \
ERICtpattributeresolver2_CXP9038530 \
# <!-- added for pm refactor --> \
ERICcbanetconfmanager_CXP9031308 \
ERICnetconfresourceadapterxaapimodule_CXP9032566 \
ERICnetconfresourceadapter_CXP9031608 \
ERICnetconfsessionapi_CXP9032052 \
ERICcomecimpmicmoduleapi_CXP9032325 \
ERICcomecimpmicmoduleimpl_CXP9032343 \
# <!-- SNMP module packages --> \
ERICsnmppmoperationshandler_CXP9034533 \
ERICsnmppmfilecollectionhandler_CXP9034536 \
ERICsnmpconnector_CXP9031526 \
ERICsnmpconnectorapi_CXP9031535 \
ERICsnmpenterpriseconnector_CXP9031525 \
ERICsnmpenterpriseconnectorapi_CXP9031534 \
ERICsnmppmengine_CXP9034537 \
EXTRwebnmssnmpapimodule_CXP9031603 && \
zypper clean -a

COPY --chown=jboss_user:root image_contents/cli/scripts/*.cli /ericsson/3pp/jboss/bin/cli/services/
COPY --chown=jboss_user:root image_contents/cli/scripts/jboss-as.conf /ericsson/3pp/jboss/jboss-as.conf
COPY --chown=jboss_user:root image_contents/post-start/mediationservice_cluster_join.sh /ericsson/3pp/jboss/bin/post-start/
COPY --chown=jboss_user:root image_contents/post-start/fls_post_start.sh /ericsson/3pp/jboss/bin/post-start/

COPY --chown=jboss_user:root image_contents/pre-start/oomKillerTuning.sh /ericsson/3pp/jboss/bin/pre-start/
COPY --chown=jboss_user:root image_contents/post-start/postinstall.sh /ericsson/3pp/jboss/bin/post-start/

COPY --chown=jboss_user:root image_contents/ddp-utils/SERVICE_GROUP_MAPPING /opt/ericsson/ddp-utils/

ENV ENM_JBOSS_BIND_ADDRESS="0.0.0.0" \
    GLOBAL_CONFIG="/gp/global.properties" \
    JBOSS_CONF="/ericsson/3pp/jboss/jboss-as.conf" \
    CLOUD_NATIVE_DEPLOYMENT="true"