import React, {Component} from 'react';
import CardList from '../components/CardList';
import SearchBox from '../components/SearchBox';
import Scroll from '../components/Scroll';
import Footer from '../components/Footer';
import ErrorBoundry from '../components/ErrorBoundry';

class App extends Component {
    constructor() {
        super();
        this.state = {
            cats: [],
            searchField: ''
        };
    }

    getData = async () => {
         const response = await fetch('https://jsonplaceholder.typicode.com/users');
         return  await response.json();
    };

    componentDidMount() {
        this.getData().then(data => {
            this.setState({cats: data});
        });
    }

    onSearchChange = (event) => {
       this.setState({searchField: event.target.value});
    };

    render() {
        const filteredCats = this.state.cats.filter(cat => {
            return cat.name.toLowerCase().includes(this.state.searchField.toLowerCase());
        });

        if(!this.state.cats.length) {
            return <>
                <h1 style={{flex:'none', alignSelf:'center'}}>Loading</h1>
            </>
        }

        return (
            <div className='tc'>
                <h1>
                    Cat Friends
                </h1>
                <SearchBox onSearchChange={this.onSearchChange}></SearchBox>
                <Scroll>
                    <ErrorBoundry>
                        <CardList cats={filteredCats}></CardList>
                    </ErrorBoundry>
                </Scroll>
                <Footer></Footer>
            </div>
        );
    }
}

export default App;