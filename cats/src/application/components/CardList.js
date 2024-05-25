import Card from "./Card";

const cardList = ({cats}) => {
    return (
        <div>
            {
                cats.map((cat, i) => <Card key={i} id={cat.id} name={cat.name} email={cat.email}/>)
            }
        </div>
    );    
};

export default cardList;