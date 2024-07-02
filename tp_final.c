#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>

typedef struct
{
    char codigo[4];
    int totalPasajeros;
    int menores;
    float totalImporte;
    float importe;
} Destino;

typedef struct
{
    char apellido[15];
    char nombre[15];
    char codigoDestino[4];
    char pagaConTarjeta;
    int dni;
    int edad;
    float importeTotal;
} Pasajero;

void cargarDestinos(Destino destinos[]);
void cargarPasajeros(Pasajero pasajeros[], int totalPasajeros, Destino destinos[]);
void mostrarMenu();
void ordenarPasajeros(Pasajero pasajeros[], int totalPasajeros);
void mostrarListaPasajerosOrdenada(Pasajero pasajeros[], int totalPasajeros);
int esNumero(char numero[]);
int validarDni();
int validarEdad();
// void ordenarPasajerosPorCodDestino(Pasajero pasajeros[], int totalPasajeros, int columna);
// char validarMedioDePago();

int main()
{
    Destino destinos[4];
    int totalPasajeros, opcionMenu, dniBuscar;

    cargarDestinos(destinos);

    printf("Ingrese cantidad de pasajeros que contrataron viajes:\n");
    do
    {
        scanf("%d", &totalPasajeros);
        if (totalPasajeros <= 0)
        {
            printf("Ingrese un numero valido:\n");
        }
        else if (totalPasajeros > 240)
        {
            printf("Limite alcanzado.\n");
        }

    } while (totalPasajeros <= 0 || totalPasajeros > 240);

    Pasajero pasajeros[totalPasajeros];
    cargarPasajeros(pasajeros, totalPasajeros, destinos);

    do
    {
        mostrarMenu();
        scanf("%d", &opcionMenu);

        switch (opcionMenu)
        {
        case 1:
            ordenarPasajeros(pasajeros, totalPasajeros);
            mostrarListaPasajerosOrdenada(pasajeros, totalPasajeros);
            break;
        case 2:
            ordenarPasajeros(pasajeros, totalPasajeros);
            // ordenarPasajerosPorCodDestino(pasajeros, totalPasajeros, 4);
            mostrarListaPasajerosOrdenada(pasajeros, totalPasajeros);
            break;
        case 3:
            printf("Lista de Destinos:\n");
            // mostrarListaDeDestinos(destinos);
            break;
        case 4:
            printf("Buscar pasajero por DNI: \nIngrese DNI: \n");
            scanf("%d", &dniBuscar);
            // escribirDatos(pasajeros, dniBuscar, totalPasajeros);
            break;
        case 5:
            printf("Elija una opcion para la Estadistica:\n");
            // mostrarMenuEstadistica(pasajeros, totalPasajeros, destinos);
            break;
        case 6:
            printf("Gracias por usar el sistema de Viaje Magico <3.\n");
            break;
        default:
            printf("Opcion no valida, intente de nuevo.\n");
            break;
        }
    } while (opcionMenu != 6);

    return 0;
};

void cargarDestinos(Destino destinos[])
{

    strcpy(destinos[0].codigo, "BRA");
    destinos[0].importe = 25000.00;
    destinos[0].totalPasajeros = 0;
    destinos[0].menores = 0;
    destinos[0].totalImporte = 0;

    strcpy(destinos[1].codigo, "MDQ");
    destinos[1].importe = 14000.00;
    destinos[1].totalPasajeros = 0;
    destinos[1].menores = 0;
    destinos[1].totalImporte = 0;

    strcpy(destinos[2].codigo, "MZA");
    destinos[2].importe = 19000.00;
    destinos[2].totalPasajeros = 0;
    destinos[2].menores = 0;
    destinos[2].totalImporte = 0;

    strcpy(destinos[3].codigo, "BRC");
    destinos[3].importe = 23000.00;
    destinos[3].totalPasajeros = 0;
    destinos[3].menores = 0;
    destinos[3].totalImporte = 0;
};

void cargarPasajeros(Pasajero pasajeros[], int totalPasajeros, Destino destinos[])
{

    for (int i = 0; i < totalPasajeros; i++)
    {
        printf("\nPasajero: %d\n", i + 1);

        pasajeros[i].dni = validarDni();

        printf("Ingrese Apellido:\n");
        scanf("%s", pasajeros[i].apellido);

        printf("Ingrese Nombre:\n");
        scanf("%s", pasajeros[i].nombre);
        pasajeros[i].edad = validarEdad();

        printf("Ingrese Codigo Destino:\nBRA- Brasil\nMDQ- Mar del Plata\nMZA- Mendoza\nBRC- Bariloche\n");
        // strcpy(pasajeros[i].codigoDestino, validarDestino(pasajeros, i, destinos));

        printf("¿Abonara con Tarjeta de Credito?\n S/N\n");
        // pasajeros[i].pagaConTarjeta = validarMedioDePago();

        // calculaImporteTotal(pasajeros, i, destinos);
    }
};

void mostrarMenu()
{
    printf("\nIngrese una opcion: \n");
    printf("1. Mostrar lista de pasajeros ordenada por Apellido y Nombre\n");
    printf("2. Mostrar lista de pasajeros ordenada por Codigo de Destino y Apellido y Nombre\n");
    printf("3. Mostrar lista de Destinos\n");
    printf("4. Buscar por Pasajero\n");
    printf("5. Mostrar Estadisticas\n");
    printf("6. Salir\n");
};

void ordenarPasajeros(Pasajero pasajeros[], int totalPasajeros)
{
    Pasajero aux;
    if (totalPasajeros > 1)
    {
        for (int i = 0; i < totalPasajeros - 1; i++)
        {
            for (int j = i + 1; j < totalPasajeros; j++)
            {
                if (strcmp(pasajeros[i].apellido, pasajeros[j].apellido) == 0)
                {
                    if (strcmp(pasajeros[i].nombre, pasajeros[j].nombre) > 0)
                    {
                        aux = pasajeros[i];
                        pasajeros[i] = pasajeros[j];
                        pasajeros[j] = aux;
                    }
                }
                else if (strcmp(pasajeros[i].apellido, pasajeros[j].apellido) > 0)
                {
                    aux = pasajeros[i];
                    pasajeros[i] = pasajeros[j];
                    pasajeros[j] = aux;
                }
            }
        }
    }
};

int esNumero(char numero[])
{
    int len = strlen(numero);
    for (int i = 0; i < len; i++)
    {
        if (!isdigit(numero[i]))
        {
            printf("Error: debe contener solo numeros, intente nuevamente ");
            return 0;
        }
    }
    return 1;
}

void mostrarListaPasajerosOrdenada(Pasajero pasajeros[], int totalPasajeros)
{
    printf("\n -Lista de Pasajeros Ordenada:\n");
    for (int i = 0; i < totalPasajeros; i++)
    {
        printf("%s\t%s\t%s\t%c\t%d\t%d\t%.2f\n",
               pasajeros[i].apellido,
               pasajeros[i].nombre,
               pasajeros[i].codigoDestino,
               pasajeros[i].pagaConTarjeta,
               pasajeros[i].dni,
               pasajeros[i].edad,
               pasajeros[i].importeTotal);
    }
};

int validarDni()
{
    bool dniValid = false;
    char dni[8];
    printf("Ingrese su DNI:\n");
    do
    {
        scanf("%s", dni);
        if (esNumero(dni) == 1)
        {
            int len = strlen(dni);
            if (len == 7 || len == 8)
            {
                int primer_digito = atoi(dni) / 1000000;
                if (primer_digito == 5 || primer_digito == 6 || (primer_digito >= 10 && primer_digito <= 60))
                {
                    printf("DNI Valido!\n");
                    dniValid = true;
                }
                else
                {
                    printf("Este DNI es invalido. Ingrese un valor valido.\n");
                }
            }
            else
            {
                printf("La longitud es invalida. Ingrese un valor valido.\n");
            }
        }
    } while (!dniValid);
    return atoi(dni);
};
