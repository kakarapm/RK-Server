# RK-Server

## Config DB

Buat yg belum install mysql

1. Download the `db-config.sh` script using the following command:

    ```shell
    wget -O db-config.sh https://raw.githubusercontent.com/kakarapm/RK-Server/main/db-config.sh
    ```

2. Make the script executable by running the following command:

    ```shell
    chmod +x db-config.sh
    ```

3. Run the `db-config.sh` script using the following command:

    ```shell
    ./db-config.sh
    ```
    
Atau
1. Run command:

    ```shell
    bash -c "$(curl -sSL https://raw.githubusercontent.com/kakarapm/RK-Server/main/db-config.sh)"
