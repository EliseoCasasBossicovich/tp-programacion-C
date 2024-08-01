// GRUPO 6
// INTEGRANTES: Justina Rey, Quintanilla Ornella, Casas Bossicovich Eliseo, Baptista Carvalho Gabriela 

Algoritmo tpIntegradorFinal_CHAN_CHAN
	definir pasajeros, destinos, dniBuscar Como Caracter
	Dimension destinos[4, 5]
	definir totalPasajeros, opcionMenu, opcionEstadistica Como Entero
	
	cargarDestinos(destinos)
	
	Escribir "Ingrese cantidad de pasajeros que contrataron viajes:"
	Repetir
		leer totalPasajeros
		
		si totalPasajeros <= 0 Entonces
			Escribir "Ingrese un numero válido."
		SiNo
			si totalPasajeros > 240 Entonces
				Escribir "Límite alcanzado."
			FinSi
		FinSi
	Mientras Que totalPasajeros <= 0 O totalPasajeros > 240
	
	Dimension pasajeros[totalPasajeros, 7]
	cargarPasajeros(pasajeros, totalPasajeros, destinos)
	
	// --- Menú de Usuario
	Escribir ""
	Repetir
        mostrarMenu
        Leer opcionMenu
		
        Segun opcionMenu Hacer
            Caso 1:
				ordenarPasajeros(pasajeros, totalPasajeros, 0, totalPasajeros)
                mostrarListaPasajerosOrdenada(pasajeros, totalPasajeros)
            Caso 2:
				ordenarPasajeros(pasajeros, totalPasajeros, 0, totalPasajeros)
				ordenarPasajerosPorCodDestino(pasajeros, totalPasajeros, 4, totalPasajeros)
                mostrarListaPasajerosOrdenada(pasajeros, totalPasajeros)
            Caso 3:
				Escribir "Lista de Destinos: "
				mostrarListaDeDestinos(destinos)
            Caso 4:
				Escribir "Buscando pasajero por DNI: "
				Escribir "Ingrese el DNI: "
				leer dniBuscar
				escribirDatos(pasajeros, dniBuscar, totalPasajeros)
            Caso 5:
				Escribir "Elija una opción para la Estadística: "
				mostrarMenuEstadistica(pasajeros, totalPasajeros, destinos)
            Caso 6:
                Escribir "Gracias por usar el sistema de Viaje Mágico."
			De Otro Modo:
				Escribir "Opción no válida, intente de nuevo."
		FinSegun
	Mientras Que opcionMenu <> 6
	
FinAlgoritmo


// Devuelve el array con columna importeTotal x cada pasajero
SubProceso calculaImporteTotal(pasajeros, f, destinos)
	definir importeTotal Como Real
	
	si (ConvertirANumero(pasajeros[f, 3]) < 5) Entonces
		importeTotal = 2000.00
	SiNo
		// Segun pasajero y destino:
		Segun pasajeros[f, 4]
			"BRA":
				importeTotal = ConvertirANumero(destinos[0, 1])
			"MDQ":
				importeTotal = ConvertirANumero(destinos[1, 1])
			"MZA":
				importeTotal = ConvertirANumero(destinos[2, 1])
			"BRC":
				importeTotal = ConvertirANumero(destinos[3, 1])
			De Otro Modo:
				Escribir "No se encontró el destino."
				importeTotal = 0
		FinSegun
	FinSi
	
	si (pasajeros[f, 5] == "S" O pasajeros[f, 5] == "s") Entonces
		importeTotal = importeTotal * 1.05;
	FinSi
	
	sumaTotalPorDestino(destinos, importeTotal, pasajeros[f,4])
	pasajeros[f, 6] = ConvertirATexto(importeTotal)
FinSubProceso

SubProceso sumaTotalPorDestino(destinos, importeTotal, codigoDestinoDePasajero)
	definir i, acumuladorDeImporte Como Entero
	
	para i = 0 Hasta 3 Hacer
		si (destinos[i, 0] == codigoDestinoDePasajero) Entonces
			acumuladorDeImporte = ConvertirANumero(destinos[i,4])
			acumuladorDeImporte = acumuladorDeImporte + importeTotal
			destinos[i,4] = ConvertirATexto(acumuladorDeImporte)
		FinSi
	FinPara
FinSubProceso

// --- Validación:

// Si es numero
Funcion bandera <- esNumero(unaCadena)
    definir i Como Entero
    definir bandera Como Logico
    
    bandera = Verdadero
    
    Para i = 0 Hasta longitud(unaCadena)-1 Hacer
        Si NO(SubCadena(unaCadena, i, i) >= "0" Y SubCadena(unaCadena, i, i) <= "9") Entonces
            bandera = Falso
        FinSi
    FinPara
	
	si bandera = Falso Entonces
		Escribir "Debe contener solo números. Intente nuevamente."
	FinSi
FinFuncion

// DNI
Funcion dniValido <- validarDNI
	definir dniValido Como caracter
	definir invalido Como Logico
	definir primer_digito Como Entero
	
	invalido = Verdadero
	Escribir "Ingrese DNI"
	
	Repetir		
		leer dniValido
		
		si esNumero(dniValido) Entonces
			si (longitud(dniValido) == 7 O longitud(dniValido) == 8) Entonces
				primer_digito = ConvertirANumero(dniValido)
				primer_digito = Trunc(primer_digito / 1000000)
				
				Si primer_digito == 5 O primer_digito == 6 O (primer_digito >= 10 Y primer_digito <= 60) Entonces
					Escribir "DNI Válido!"
					invalido = Falso
				SiNo
					Escribir "Este DNI es inválido."
					Escribir "Ingrese un valor válido:"
				FinSi
			SiNo
				Escribir "La longitud es inválida."
				Escribir "Ingrese un valor válido:"
			FinSi
		FinSi
	Mientras Que invalido
	
FinFuncion

// Edad
Funcion edadRetorno <- validarEdad
	definir edad Como caracter
	definir esInvalido Como Logico
	definir edadRetorno Como Caracter
	
	esInvalido = Verdadero
	
	Repetir
		leer edad
		
		si esNumero(edad) Entonces
			si(ConvertirANumero(edad) > 0 Y ConvertirANumero(edad) < 120) Entonces
				esInvalido = Falso
			SiNo
				Escribir "Ingrese una edad válida."
			FinSi
		FinSi
	Mientras Que esInvalido
	
	edadRetorno = edad
FinFuncion


// Código de Destino
Funcion codigoDeDestino <- validarDestino(pasajeros, f, destinos)
	definir codigoDeDestino Como Caracter
	definir contador, contadorMenores como entero
	definir bandera Como Logico
	
	bandera = Falso
	
	Repetir
		leer codigoDeDestino
		codigoDeDestino = Mayusculas(codigoDeDestino)
		
		Segun codigoDeDestino
			"BRA":
				si (ConvertirANumero(destinos[0,2]) < 60) Entonces
					contador = ConvertirANumero(destinos[0,2])
					contador = contador+1;
					destinos[0,2] = ConvertirATexto(contador)
					
					si (ConvertirANumero(pasajeros[f,3]) < 5) Entonces
						contadorMenores = ConvertirANumero(destinos[0,3])
						contadorMenores = contadorMenores+1;
						destinos[0,3] = ConvertirATexto(contadorMenores)
					FinSi
					
					bandera = Verdadero
				SiNo
					Escribir "Brasil Alcanzó su limite de cupo. Ingrese otro destino: "
				FinSi
			"MDQ":
				si (ConvertirANumero(destinos[1,2]) < 60) Entonces
					contador = ConvertirANumero(destinos[1,2])
					contador = contador+1;
					destinos[1,2] = ConvertirATexto(contador)
					
					si (ConvertirANumero(pasajeros[f,3]) < 5) Entonces
						contadorMenores = ConvertirANumero(destinos[1,3])
						contadorMenores = contadorMenores+1;
						destinos[1,3] = ConvertirATexto(contadorMenores)
					FinSi
					
					bandera = Verdadero
				SiNo
					Escribir "Mar del Plata Alcanzó su limite de cupo. Ingrese otro destino: "
				FinSi
			"MZA":
				si (ConvertirANumero(destinos[2,2]) < 60) Entonces
					contador = ConvertirANumero(destinos[2,2])
					contador = contador+1;
					destinos[2,2] = ConvertirATexto(contador)
					
					si (ConvertirANumero(pasajeros[f,3]) < 1) Entonces
						contadorMenores = ConvertirANumero(destinos[2,3])
						contadorMenores = contadorMenores+1;
						destinos[2,3] = ConvertirATexto(contadorMenores)
					FinSi
					
					bandera = Verdadero
				SiNo
					Escribir "Mendoza Alcanzó su limite de cupo. Ingrese otro destino: "
				FinSi
			"BRC":
				si (ConvertirANumero(destinos[3,2]) < 60) Entonces
					contador = ConvertirANumero(destinos[3,2])
					contador = contador+1;
					destinos[3,2] = ConvertirATexto(contador)
					
					si (ConvertirANumero(pasajeros[f,3]) < 5) Entonces
						contadorMenores = ConvertirANumero(destinos[3,3])
						contadorMenores = contadorMenores+1;
						destinos[3,3] = ConvertirATexto(contadorMenores)
					FinSi
					
					bandera = Verdadero
				SiNo
					Escribir "Bariloche Alcanzó su limite de cupo. Ingrese otro destino: "
				FinSi
			De Otro Modo:
				Escribir "Destino no válido."
		FinSegun
	Mientras Que bandera == Falso
FinFuncion

funcion pago <- validarMedioDePago
	definir pago Como Caracter
	definir bandera como logico
	
	bandera = falso
	
	Repetir
		leer pago
		
		si (Mayusculas(pago) == "S" O Mayusculas(pago) == "N") Entonces
			bandera = Verdadero
		SiNo
			Escribir "Ingrese una respuesta válida."
			Escribir "S (sí) / N (no)"
		FinSi
	Mientras Que bandera = falso
FinFuncion

// --- Mostrar por pantalla:

SubProceso mostrarMenu
	Escribir ""
	Escribir "Ingrese una opción:"
	Escribir "1. Mostrar lista de pasajeros ordenada por Apellido y Nombre"
	Escribir "2. Mostrar lista de pasajeros ordenada por Código Destino y Apellido - Nombre"
	Escribir "3. Mostrar lista de Destinos"
	Escribir "4. Buscar por pasajero"
	Escribir "5. Mostrar estadísticas"
	Escribir "6. Salir"
FinSubProceso

SubProceso mostrarListaPasajerosOrdenada(pasajeros, totalPasajeros)
	Definir i, j, k Como Entero
	
	Escribir ""
	Escribir " - Lista de Pasajeros Ordenada: "
	Escribir ""
	
	para i = 0 Hasta totalPasajeros-1 Hacer
		Para j = 0 Hasta 6 Hacer
			Escribir Sin Saltar pasajeros[i, j]
			Escribir Sin Saltar "  |  "
		FinPara
		Escribir ""
	FinPara
FinSubProceso

SubProceso mostrarMenuEstadistica(pasajeros, totalPasajeros, destinos)
	Definir opcionEstadistica Como Entero
	
	Escribir "1- Analizar estadísticas por cada destino porcentaje de pasajeros: "
	Escribir "2- Analizar el destino más solicitado: "
	Escribir "3- Analizar porcentaje de menores de 5 años de cada destino: "
	leer opcionEstadistica 
	
	Segun opcionEstadistica Hacer
		1:
			porcentajePorDestino(destinos, totalPasajeros)
		2:
			mostrarDestinoMasSolicitado(destinos)
		3:
			porcentajeMenoresPorDestino(destinos)
		De Otro Modo:
			Escribir "No encontrado."
	FinSegun
FinSubProceso

SubProceso escribirDatos(personas, dniBuscar, totalPasajeros)
	Definir pasajero, i Como entero
	
	pasajero = buscarSecuencial(personas, dniBuscar, totalPasajeros)
	
	si (pasajero == -1) Entonces
		Escribir "Pasajero no encontrado."
	SiNo
		Escribir "Datos del pasajero: "
		para i = 0 Hasta 6 Hacer
			Escribir Sin Saltar "  - "
			segun i
				0:
					escribir Sin Saltar "NOMBRE:   "
				1:
					Escribir sin saltar "APELLIDO:   "
				2:
					escribir Sin Saltar "DNI:   "
				3:
					Escribir sin saltar "EDAD:   "
				4:
					escribir Sin Saltar "CÓDIGO DE DESTINO:   "
				5:
					Escribir sin saltar "PAGA CON TARJ. CRÉDITO:   "
				6:
					escribir Sin Saltar "IMPORTE TOTAL:   "
			FinSegun
			
			Escribir personas[pasajero, i]
		FinPara
	FinSi
FinSubProceso

SubProceso porcentajePorDestino(destinos, totalPasajeros)
	Definir i Como EnteroporcentajePorDestino
	definir porcentaje Como Real
	
	Escribir ""
	
	para i = 0 Hasta 3 Hacer
		porcentaje = (ConvertirANumero(destinos[i, 2]) * 100) / totalPasajeros
		Escribir "Destino: ", destinos[i, 0], " Porcentaje de pasajeros: ", trunc(porcentaje), " %"
	FinPara	
FinSubProceso

SubProceso porcentajeMenoresPorDestino(destinos)
	Definir i Como Entero
	definir porcentaje Como Real
	
	para i = 0 Hasta 3 Hacer
		si ConvertirANumero(destinos[i,2]) > 0 Entonces
			porcentaje = (ConvertirANumero(destinos[i, 3]) * 100) / ConvertirANumero(destinos[i,2])
			Escribir "Destino: ", destinos[i, 0], " Porcentaje de pasajeros menores de 5 años: ", trunc(porcentaje), " %"
		SiNo
			Escribir "El destino ", destinos[i, 0], " no fue visitado."
		FinSi
	FinPara	
FinSubProceso

SubProceso mostrarDestinoMasSolicitado(destinos)
    definir i Como Entero
    definir masVisitado, visitasEmpatadas Como Entero
    definir destinoMasVisitado, destinosEmpatados Como Caracter
    
    destinosEmpatados = ""
	
    masVisitado = ConvertirANumero(destinos[0, 2])
    destinoMasVisitado = destinos[0, 0]
    destinosEmpatados = destinos[0, 0]
	
    para i = 1 Hasta 3 Hacer
        si ConvertirANumero(destinos[i, 2]) > masVisitado Entonces
            masVisitado = ConvertirANumero(destinos[i, 2])
            destinoMasVisitado = destinos[i, 0]
            destinosEmpatados = destinos[i, 0]
			visitasEmpatadas = ConvertirANumero(destinos[i,2])
        SiNo
            si ConvertirANumero(destinos[i, 2]) == masVisitado Entonces
                destinosEmpatados = destinosEmpatados + ", " + destinos[i, 0]
				visitasEmpatadas = ConvertirANumero(destinos[i,2])
            FinSi
        FinSi
    FinPara
    
    Escribir ""
    Escribir "El/Los destino(s) más visitado(s) fue/fueron: ", destinosEmpatados
	Escribir "Con un total de: ", visitasEmpatadas, " pasajeros."
FinSubProceso

SubProceso mostrarListaDeDestinos(destinos)
	definir i, f Como Entero
	
	para f = 0 Hasta 3 Hacer
		para i = 0 Hasta 4 Con Paso 2 Hacer
			Escribir Sin Saltar destinos[f,i], "  |  "
		FinPara
		Escribir ""
	FinPara
FinSubProceso

// --- Busqueda:

// Busqueda x DNI
funcion posicion <- buscarSecuencial(personas, dniBuscar, totalPasajeros)
	definir i, posicion Como Entero
	
	para i = 0 Hasta totalPasajeros-1 Hacer
		si personas[i, 2] == dniBuscar Entonces
			posicion = i
			i = totalPasajeros
		SiNo
			posicion = -1
		FinSi
	FinPara
FinFuncion


// --- Ordenamiento: 

// ordenar pasajeros por apellido, nombre
SubProceso ordenarPasajeros(personas, f, columna_ord, totalPasajeros)
	Definir i, j, k Como Entero
	definir aux Como Caracter
	
	si (totalPasajeros > 1) Entonces
		para i = 0 Hasta f-2 Hacer
			para j = i+1 Hasta f-1 Hacer
				si personas[i, columna_ord] == personas[j, columna_ord] Entonces
					si personas[i, columna_ord+1] > personas[j, columna_ord+1] Entonces
						Para k<-0 Hasta 6 Con Paso 1 Hacer
							aux = personas[i, k]
							personas[i,k] = personas[j,k]
							personas[j,k] = aux
						Fin Para
					FinSi
				SiNo
					si personas[i, columna_ord] > personas[j, columna_ord] Entonces
						Para k<-0 Hasta 6 Con Paso 1 Hacer
							aux = personas[i, k]
							personas[i,k] = personas[j,k]
							personas[j,k] = aux
						Fin Para
					FinSi
				FinSi
			FinPara
		FinPara
	FinSi
	
FinSubProceso

//Ordenar por Código Destino
SubProceso ordenarPasajerosPorCodDestino(pasajeros, f, columna_ord, totalPasajeros)
	Definir i, j, k Como Entero
    definir aux Como Caracter
    
	si (totalPasajeros > 1) Entonces
		para i = 0 Hasta f-2 Hacer
			para j = i+1 Hasta f-1 Hacer
				si pasajeros[i, columna_ord] > pasajeros[j, columna_ord] Entonces
					Para k<-0 Hasta 6 Con Paso 1 Hacer
						aux = pasajeros[i, k]
						pasajeros[i,k] = pasajeros[j,k]
						pasajeros[j,k] = aux
					Fin Para
				FinSi
			FinPara
		FinPara
	FinSi
    
FinSubProceso


// --- Carga Arreglo:

// Devuelve arreglo Pasajeros
SubProceso cargarPasajeros(pasajeros, totalPasajeros, destinos)
	definir f, c Como Entero
	
	para f = 0 Hasta totalPasajeros-1 Hacer
		Escribir ""
		Escribir "Pasajero: ", f+1
		
		pasajeros[f, 2] = validarDNI
		
		Escribir "Ingrese Apellido"
		leer pasajeros[f, 0]
		
		Escribir "Ingrese Nombre"
		leer pasajeros[f, 1]
		
		Escribir "Ingrese Edad:"
		pasajeros[f, 3] = validarEdad
		
		Escribir "Ingrese Código de Destino"
		Escribir "BRA- Brasil"
		Escribir "MDQ- Mar del Plata"
		Escribir "MZA- Mendoza"
		Escribir "BRC- Bariloche"
		pasajeros[f, 4] = validarDestino(pasajeros, f, destinos)
		
		
		Escribir "¿Abonará con Tarjeta de Crédito?"
		Escribir "S / N"
		pasajeros[f, 5] = validarMedioDePago
		
		calculaImporteTotal(pasajeros, f, destinos)
	FinPara
FinSubProceso


// Carga códigos de destino y su importe
SubProceso cargarDestinos(destinos)
	destinos[0,0] = "BRA"
	destinos[1,0] = "MDQ"
	destinos[2,0] = "MZA"
	destinos[3,0] = "BRC"
	
	destinos[0,1] = "25000.00"
	destinos[1,1] = "14000.00"
	destinos[2,1] = "19000.00"
	destinos[3,1] = "23000.00"
	
	destinos[0,2] = "0"
	destinos[1,2] = "0"
	destinos[2,2] = "0"
	destinos[3,2] = "0"
	
	destinos[0,3] = "0"
	destinos[1,3] = "0"
	destinos[2,3] = "0"
	destinos[3,3] = "0"
FinSubProceso