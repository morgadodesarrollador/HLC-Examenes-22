import { PassportStrategy } from '@nestjs/passport';
import { InjectRepository } from '@nestjs/typeorm';
import { Strategy, ExtractJwt } from 'passport-jwt';
import { Repository } from 'typeorm';
import { User } from '../entities/user.entity';
import { ConfigService } from '@nestjs/config';
import { JwtPayload } from '../interfaces/jwt-payload.interface';
import { UnauthorizedException } from '@nestjs/common';



export class JwtStrategy extends PassportStrategy (Strategy) {

    constructor(
        @InjectRepository (User)
        private readonly userRepository: Repository<User>,
        ConfigService: ConfigService
    ){
        super({
            secretOrKey: ConfigService.get('JWT_SECRET'),
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken()
        })
    }

    async validate( payload: JwtPayload ): Promise<User>{
        const { email } = payload;
        const user = await this.userRepository.findOneBy({ email });
        if (!user )
            throw new UnauthorizedException('Token no valido');
        
        if (!user.isActive ) //existe pero no activo
            throw new UnauthorizedException('usuario no activo');
        
        return user;
    }
}