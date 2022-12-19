import { Module } from '@nestjs/common';
import { SeedService } from './seed.service';
import { SeedController } from './seed.controller';
import { AuthModule } from '../auth/auth.module';
import { AparatosModule } from '../aparatos/aparatos.module';
import { IncidenciasModule } from '../incidencias/incidencias.module';

@Module({
  controllers: [SeedController],
  providers: [SeedService],
  imports: [ AuthModule, AparatosModule, IncidenciasModule]
})
export class SeedModule {}
