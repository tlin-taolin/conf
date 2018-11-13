FROM itamtao/base:cuda9

# Set the locale to en_US
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# Install telegraf
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf_1.8.3-1_amd64.deb -O telegraf.deb \
    && dpkg -i telegraf.deb \
    && rm telegraf.deb
COPY telegraf.conf /etc/telegraf/telegraf.conf

# Required environment variables:
# Telegraf
ENV JOBMONITOR_TELEGRAF_HOST='localhost' \
    JOBMONITOR_TELEGRAF_PORT='8092'

# InfluxDB
ENV JOBMONITOR_TIMESERIES_HOST='' \
    JOBMONITOR_TIMESERIES_PORT='8086' \
    JOBMONITOR_TIMESERIES_DB='jobmonitor'

# Add an entrypoint script that will start the telegraf service
COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
