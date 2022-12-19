import { Incidencia } from "src/modulos/incidencias/entities/incidencia.entity";
import { Column, Entity, OneToMany, PrimaryColumn } from "typeorm";

@Entity('aparatos')
export class Aparato {
    @PrimaryColumn()
    cod:string;

    @Column('text', { unique: true })
    nombre: string;

    @Column('text')
    aula: string;

    @Column('text')
    tipo: string;

    @Column()
    anio: number;

    @OneToMany(
        () => Incidencia,
        (Incidencia) => Incidencia.aparato,
        { cascade: true, eager: true  }
    )
    incidencias?: Incidencia[];
    
}
