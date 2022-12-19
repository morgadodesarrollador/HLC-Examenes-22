import { Injectable } from '@nestjs/common';
import { AuthService } from '../auth/auth.service';
import { AparatosService } from '../aparatos/aparatos.service';
import dataUsuarios from '../seed/data/usuarios.json';
import dataAparatos from '../seed/data/aparatos.json';
import dataIncidencias from '../seed/data/incidencias.json';
import { IncidenciasService } from '../incidencias/incidencias.service';

@Injectable()
export class SeedService {

  constructor(
    private readonly userService: AuthService,
    private readonly aparatosService: AparatosService,
    private readonly incidenciasService: IncidenciasService
  ){}
  async runData() {

    await this.userService.deleteAllUsers();
    await this.loadUsers();

    await this.aparatosService.deleteAllProductos();
    await this.loadAparatos();

    await this.loadIncidencias();
    return dataAparatos;


  }

  private async loadUsers() {
    const insertPromises = [];
    dataUsuarios.forEach( usuario => {
      insertPromises.push(this.userService.register(usuario))
    });
    await Promise.all(insertPromises);
  }

  private async loadAparatos() {
    const insertPromises = [];
    dataAparatos.forEach( aparato => {
      insertPromises.push(this.aparatosService.create(aparato))
    });
    await Promise.all(insertPromises);
  }
  private async loadIncidencias() {
    const insertPromises = [];
    dataIncidencias.forEach( incidencia => {
      insertPromises.push(this.incidenciasService.create(incidencia))
    });
    await Promise.all(insertPromises);
  }


  
}
