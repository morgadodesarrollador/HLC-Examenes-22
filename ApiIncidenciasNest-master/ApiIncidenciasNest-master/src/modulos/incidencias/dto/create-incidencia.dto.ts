import { IsIn, IsString, MinLength } from "class-validator";
import { Column, PrimaryGeneratedColumn } from "typeorm";

export class CreateIncidenciaDto {

    @IsString()
    idea:string;

    @IsString()
    cod:string;

    @IsString()
    descripcion:string;

 
    @IsString()
    fecha:string;

    @IsIn(['pendiente', 'finalizada', 'en proceso'])
    status: string = 'pendiente';
}
