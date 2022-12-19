import { IsIn, IsNumber, IsString, MaxLength, MinLength } from "class-validator";

export class CreateAparatoDto {

    @IsString()
    cod: string;

    @IsString()
    @MinLength(1)
    nombre:string;

    @IsString()
    @IsIn(['Proyector','Ordenador','Pizarra Digital','Auriculares','Altavoces'])
    tipo: string;

    @IsNumber()
    @MinLength(1)
    anio:number;

    @IsString()
    @IsIn(['B1','B2','B3','C1','C2','C3','C4','A2','A2'])
    aula: string;
}
