import '../../styles/Card.css';
import React from 'react';

const Card = ({id, name, email})=> {
    return (
        <div className="bg-light-green grow shadow-5 dib br3 pa3 ma2">
            <img alt='robots' src={`https://robohash.org/${id}?set=set4`}></img>
            <div>
                <h2>{name}</h2>
                <p>{email}</p>
            </div>
        </div>
    );
};

export default Card;
