import { Incidencia } from "src/modulos/incidencias/entities/incidencia.entity";
import { Column, Entity, OneToMany, PrimaryColumn, PrimaryGeneratedColumn } from "typeorm";

@Entity('users')
export class User {

    @PrimaryColumn()
    idea:string;

    @Column('text')
    nombre: string;

    @Column('text', { unique: true })
    email: string;

    @Column('text', { select: false })
    password: string;

    @Column('bool', { default: true })
    isActive: boolean = true;

    @Column('text')
    rol: string;

    @OneToMany(
        () => Incidencia,
        (Incidencia) => Incidencia.usuario,
        { cascade: true, eager: true  }
    )
    incidencias?: Incidencia[];
}
