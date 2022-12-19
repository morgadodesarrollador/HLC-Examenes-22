import { Aparato } from "src/modulos/aparatos/entities/aparato.entity";
import { User } from "src/modulos/auth/entities/user.entity";
import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";

@Entity('Incidencias')
export class Incidencia {

    @PrimaryGeneratedColumn('uuid')
    codigo: string;

    @Column('text')
    descripcion: string;

    @Column('text')
    fecha: string;

    @Column('text')
    status: string;

    @ManyToOne(
        () => Aparato,
        (Aparato) => Aparato.incidencias,
        {  onDelete: 'CASCADE' }    
    )
    aparato?: Aparato;

    @ManyToOne(
        () => User,
        (User) => User.incidencias,
        {  onDelete: 'CASCADE' }    
    )
    usuario: User;
}
