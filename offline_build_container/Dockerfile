# Start with base micro_ros_static_library_builder
FROM microros/micro_ros_static_library_builder:foxy

ADD ./online_setup.sh /
RUN /online_setup.sh

ENTRYPOINT ["/entrypoint.sh"]
